import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/models/item_model.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction_model.dart';
import '../pages/detail_history_page.dart';
import '../pages/pay_midtrans_page.dart';
import '../theme.dart';
import 'package:http/http.dart' as http;

class TransactionProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  set transactions(List<TransactionModel> carts) {
    _transactions = transactions;
    notifyListeners();
  }

  addTransactions(
    context,
    List<ItemModel> carts,
    String payment,
    int ongkir,
    int kodeUnik,
    int total,
    List<Map<String, dynamic>> carts2,
    String address,
    String idCostumer,
    String nama,
    String email,
    String phone,
    int subtotal,
  ) async {
    CollectionReference ref = firestore.collection('transactions');
    ref.get().then((snap) async {
      CollectionReference transac = firestore.collection('transactions');

      if (payment != "COD") {
        _transactions.add(
          TransactionModel(
              id: Uuid().v4(),
              idCashier: "7885863e-2bc1-54d7-bc65-4f039daa2532",
              payment: payment,
              date: DateTime.now(),
              address: address,
              idCostumer: idCostumer,
              items: carts,
              totalProducts: carts2.length,
              totalTransaction: total,
              status: 'Bayar',
              setOngkir: true,
              ongkir: ongkir,
              kodeUnik: kodeUnik,
              keterangan: ''),
        );
      } else {
        _transactions.add(
          TransactionModel(
              id: Uuid().v4(),
              idCashier: "7885863e-2bc1-54d7-bc65-4f039daa2532",
              payment: payment,
              date: DateTime.now(),
              address: address,
              idCostumer: idCostumer,
              items: carts,
              totalProducts: carts2.length,
              totalTransaction: total,
              status: 'Proses',
              setOngkir: false,
              ongkir: ongkir,
              kodeUnik: kodeUnik,
              keterangan: ''),
        );
      }

      transac.doc('${transactions[0].id.toString()}').set({
        'id': transactions[0].id,
        'tanggal': transactions[0].date,
        'bayar': 0,
        'id_customer': transactions[0].idCostumer,
        'address': transactions[0].address,
        'items': carts2,
        'total_produk': transactions[0].totalProducts,
        'total_transaksi': transactions[0].totalTransaction,
        'id_kasir': transactions[0].idCashier,
        'payment': transactions[0].payment,
        'ongkir': transactions[0].ongkir,
        'kode_unik': transactions[0].kodeUnik,
        'ppn': 0,
        'ppl': 0,
        'subtotal': subtotal,
        'status': transactions[0].status,
        'setOngkir': transactions[0].setOngkir,
        'keterangan': transactions[0].keterangan,
      });

      print('${transactions[0].kodeUnik}');
      print('${transactions[0].totalTransaction}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "Menambahkan. Mohon Tunggu .....",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          backgroundColor: primaryColor,
        ),
      );

      if (transactions[0].payment!.contains("MidTrans")) {
        String sandBox =
            "https://app.sandbox.midtrans.com/snap/v1/transactions";
        String authSandBox =
            "Basic U0ItTWlkLXNlcnZlci1WM25HNktjMkNZY2F2MEpqZ3h6NHNRa0o=";

        String production = "https://app.midtrans.com/snap/v1/transactions";
        String authProduction =
            "Basic TWlkLXNlcnZlci1zaVI1OUpRUkotNWN0dkg3dDBrcVd2NTM6";

        print(transactions[0].toJson());
        print(carts2);

        var url = sandBox;
        var headers = {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "${authSandBox}",
        };

        var body = jsonEncode(
          {
            "transaction_details": {
              "order_id": transactions[0].id,
              "gross_amount": transactions[0].totalTransaction,
            },
            "credit_card": {
              "secure": true,
            },
            "customer_details": {
              "first_name": nama,
              "last_name": "",
              "email": email,
              "phone": phone,
            },
            "item_details": [
              {
                "id": '998',
                "price": transactions[0].ongkir,
                "quantity": 1,
                "name": 'ongkir',
                "brand": "Ongkir",
                "merchant_name": "Galeri LAM",
              },
              {
                "id": '999',
                "price": transactions[0].kodeUnik,
                "quantity": 1,
                "name": 'Kode Unik',
                "brand": "Kode Unik",
                "merchant_name": "Galeri LAM",
              },
              for (var cart in carts2)
                {
                  "id": cart['id'],
                  "price": cart['harga_jual'],
                  "quantity": cart['jumlah'],
                  "name": cart['nama_produk'],
                  "brand": cart['nama_produk'],
                  "merchant_name": "Galeri LAM",
                }
            ]
          },
        );

        var response =
            await http.post(Uri.parse(url), headers: headers, body: body);
        print(response.body);

        if (response.body.isNotEmpty) {
          print("Pindah Halaman");
          Map<String, dynamic> temp = json.decode(response.body);
          String url = temp['redirect_url'];

          transac.doc(transactions[0].id).update({'redirect_url': url});

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayMidtransPage(
                url: url,
              ),
            ),
          );
        } else {
          firestore
              .collection("transactions")
              .orderBy('tanggal', descending: true)
              .limit(1)
              .get()
              .then((value) {
            value.docs.map((e) {
              TransactionModel trans = TransactionModel.fromJson(e.data());
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailHistoryPage(transaction: trans),
                ),
              );
            }).toList();
          });
        }
      }

      sendNotificationMessage(
        "Pesanan Baru",
        "Pesanan Online ${transactions[0].id} ${transactions[0].totalProducts} Produk, dengan Total ${transactions[0].totalTransaction} ",
        "cLMbgDpMSSWAGRr-n9ArrS:APA91bEa_XoQ6aBJzxh_azqpeA-L3sIwkcfHWV-THw16MIARtOc0ohGdxl4GVfRzwRwN5trZ3L-oMV6eyGzW1dIZe9yzn91v1ycIeqir1Hr9oo1wVpDATaqikzygEaQ8epZana_qyxTW",
      );
    });
  }

  void sendNotificationMessage(String title, String body, String token) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAATv2OdgQ:APA91bFRUB1YE8sv0iR_AwEHOH2QZuQNj_BkCJ67h8v7tEOBdCiMOBEsDw13WhoAX8lpoVaXCQqbT-T15GxGg7zaggMOEAG9KfItRrypXnoFAQogSvtB0VDhJBSK0rL4wLYToWkdpjEu',
          },
          body: jsonEncode({
            'notification': {
              'body': '${body}',
              'title': '${title}',
            },
            'priority': 'high',
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': '${token}'
          }));
    } catch (e) {
      print(e);
    }
  }
}
