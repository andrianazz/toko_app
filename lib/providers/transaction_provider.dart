import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/models/item_model.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction_model.dart';
import '../pages/detail_history_page.dart';
import '../theme.dart';

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
    int total,
    List<Map<String, dynamic>> carts2,
    String address,
    String idCostumer,
  ) async {
    CollectionReference ref = firestore.collection('transactions');
    ref.get().then((snap) {
      CollectionReference transac = firestore.collection('transactions');

      _transactions.add(
        TransactionModel(
            id: Uuid().v1(),
            idCashier: "7885863e-2bc1-54d7-bc65-4f039daa2532",
            payment: payment,
            date: DateTime.now(),
            address: address,
            idCostumer: idCostumer,
            items: carts,
            totalProducts: carts2.length,
            totalTransaction: total,
            status: 'Proses',
            ongkir: ongkir,
            keterangan: ''),
      );

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
        'status': transactions[0].status,
        'keterangan': transactions[0].keterangan,
      });

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

      firestore
          .collection("transactions")
          .orderBy('tanggal', descending: true)
          .limit(1)
          .get()
          .then((value) {
        value.docs.map((e) {
          TransactionModel trans =
              TransactionModel.fromJson(e.data() as Map<String, dynamic>);
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailHistoryPage(transaction: trans),
            ),
          );
        }).toList();
      });
    });
  }
}
