import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_app/models/city_rajaongkir_model.dart';
import 'package:toko_app/models/cost_rajaongkir_model.dart';
import 'package:toko_app/models/province_rajaongkir_model.dart';
import 'package:toko_app/providers/cart_provider.dart';
import 'package:toko_app/theme.dart';
import 'package:toko_app/widgets/cart_widget.dart';
import '../providers/transaction_provider.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isFinish = false;
  int kodeUnik = Random().nextInt(499);
  int ongkir = 0;

  List<String> pembayaran = ["Bayar Langsung", "COD"];
  String selectedPembayaran = "Bayar Langsung";
  List<String> ekspedisi = ["jne", "tiki", "pos"];
  String selectedEkspedisi = "";

  List payments = [
    'Dana',
    "GoPay",
    'ShopeePay',
    'OVO',
    'MidTrans',
  ];
  String selectedPayment = "";

  String provinceID = "";
  String cityID = "";
  List<CostRajaongkirModel>? costRaja = [];

  @override
  void initState() {
    super.initState();
    getId();
    getAll();
  }

  String idCostumer = '';
  String nama = '';
  String email = '';
  String phone = '';
  String alamat = '';
  String kotaCost = '';

  Future<void> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id") ?? '';

    setState(() {
      idCostumer = id;
    });
  }

  Future<void> getAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String nameString = pref.getString("name") ?? '';
    String emailString = pref.getString("email") ?? '';
    String phoneString = pref.getString("phone") ?? '';
    String address = pref.getString("alamat") ?? '';
    String kecamatan = pref.getString("kecamatan") ?? '';
    String kelurahan = pref.getString("kelurahan") ?? '';
    String kota = pref.getString("kota") ?? '';
    String provinsi = pref.getString("provinsi") ?? '';

    setState(() {
      alamat = '$address, $kecamatan, $kelurahan, $kota, $provinsi';
      kotaCost = '$kota';
      nama = '$nameString';
      email = '$emailString';
      phone = '$phoneString';
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    var rupiah = NumberFormat.currency(name: "Rp. ", decimalDigits: 0);

    return ListView(
      children: [
        const SizedBox(height: 30),
        header(),
        const SizedBox(height: 40),
        //Cart
        cartProvider.carts.isNotEmpty
            ? Container(
                height: 250,
                child: ListView(
                  children: cartProvider.carts
                      .map((cart) => InkWell(
                            splashColor: redColor,
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => CupertinoAlertDialog(
                                        title:
                                            Text('Konfirmasi menghapus Produk'),
                                        content: Text(
                                            'Apa kamu yakin inging menghapus ${cart.name!}'),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: Text('Batal'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text('Hapus'),
                                            onPressed: () {
                                              cartProvider.removeCart(cart.id!);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ));
                            },
                            child: CartWidget(
                              items: cart,
                            ),
                          ))
                      .toList(),
                ),
              )
            : SizedBox(),
        cartProvider.carts.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: pembayaran
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPembayaran = e;
                            print(selectedPembayaran);
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: e == selectedPembayaran
                                    ? primaryColor
                                    : greyColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e,
                                style: primaryText.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: e == selectedPembayaran
                                      ? primaryColor
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            : SizedBox(),
        cartProvider.carts.isNotEmpty && selectedPembayaran != "COD"
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "Pembayaran Manual",
                        style: primaryText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      children: [
                        Column(
                          children: payments
                              .take(4)
                              .map((pay) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPayment = pay;
                                        print(selectedPayment);
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 80,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: pay == selectedPayment
                                                ? primaryColor
                                                : greyColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pay,
                                            style: primaryText.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: pay == selectedPayment
                                                  ? primaryColor
                                                  : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Kirimkan ke akun ${pay} secara manual melalui aplikasi ${pay}",
                                            style: primaryText.copyWith(
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      title: Text(
                        "Pembayaran Otomatis",
                        style: primaryText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      children: [
                        Column(
                          children: payments
                              .skip(4)
                              .map((pay) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPayment = pay;
                                        print(selectedPayment);
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 80,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: pay == selectedPayment
                                                ? primaryColor
                                                : greyColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pay,
                                            style: primaryText.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: pay == selectedPayment
                                                  ? primaryColor
                                                  : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Kirimkan ke akun ${pay} secara otomatis melalui aplikasi ${pay}",
                                            style: primaryText.copyWith(
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : SizedBox(),
        SizedBox(height: 20),
        cartProvider.carts.isNotEmpty
            ? Column(
                children: [
                  Text(
                    "Ekspedisi pengiriman",
                    style: primaryText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownSearch<ProvinceRajaongkirModel>(
                      asyncItems: (text) async {
                        Uri url = Uri.parse(
                            "https://api.rajaongkir.com/starter/province");

                        try {
                          final response = await http.get(
                            url,
                            headers: {
                              'Content-Type':
                                  'application/x-www-form-urlencoded',
                              'key': '065a4fd45e5f3239a54a40105651accf'
                            },
                          );

                          Map<String, dynamic> data =
                              json.decode(response.body);
                          var statusCode = data["rajaongkir"]["status"]["code"];

                          if (statusCode != 200) {
                            throw data["rajaongkir"]["status"]["description"];
                          }

                          var listAllProvince =
                              data["rajaongkir"]["results"] as List<dynamic>;

                          print(listAllProvince);

                          var model = listAllProvince
                              .map((e) => ProvinceRajaongkirModel.fromJson(e))
                              .toList();

                          return model;
                        } catch (e) {
                          return [];
                        }
                      },
                      onChanged: (value) => setState(() {
                        provinceID = value!.provinceId!;
                        print(provinceID);
                      }),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Provinsi",
                          hintText: "Pilih Provinsi",
                        ),
                      ),
                      itemAsString: (ProvinceRajaongkirModel prov) =>
                          prov.province!,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownSearch<CityRajaongkirModel>(
                      asyncItems: (text) async {
                        Uri url = Uri.parse(
                            "https://api.rajaongkir.com/starter/city?province=$provinceID");

                        try {
                          final response = await http.get(
                            url,
                            headers: {
                              'Content-Type':
                                  'application/x-www-form-urlencoded',
                              'key': '065a4fd45e5f3239a54a40105651accf'
                            },
                          );

                          Map<String, dynamic> data =
                              json.decode(response.body);
                          var statusCode = data["rajaongkir"]["status"]["code"];

                          if (statusCode != 200) {
                            throw data["rajaongkir"]["status"]["description"];
                          }

                          var listAllCity =
                              data["rajaongkir"]["results"] as List<dynamic>;

                          print(listAllCity);

                          var model = listAllCity
                              .map((e) => CityRajaongkirModel.fromJson(e))
                              .toList();

                          return model;
                        } catch (e) {
                          print(e);
                          return [];
                        }
                      },
                      onChanged: (value) => setState(() {
                        cityID = value!.cityId!;
                        print(cityID);
                      }),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Kota",
                          hintText: "Pilih Kota",
                        ),
                      ),
                      itemAsString: (CityRajaongkirModel city) =>
                          city.cityName!,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: ekspedisi
                          .map(
                            (e) => GestureDetector(
                              onTap: () async {
                                setState(() {
                                  selectedEkspedisi = e;
                                  print(selectedEkspedisi);
                                });

                                if (selectedEkspedisi != "") {
                                  var urlCost =
                                      "https://api.rajaongkir.com/starter/cost";

                                  var headers = {
                                    'Content-Type':
                                        'application/x-www-form-urlencoded',
                                    'key': '065a4fd45e5f3239a54a40105651accf',
                                  };

                                  var body = new Map<String, dynamic>();
                                  body['origin'] = '350';
                                  body['destination'] = cityID;
                                  body['weight'] = '1700';
                                  body['courier'] = selectedEkspedisi;

                                  var response2 = await http.post(
                                      Uri.parse(urlCost),
                                      headers: headers,
                                      body: body);

                                  Map<String, dynamic> apiCost =
                                      json.decode(response2.body);

                                  var dataAllCost = apiCost["rajaongkir"]
                                      ["results"] as List<dynamic>;

                                  var costs = dataAllCost
                                      .map((e) =>
                                          CostRajaongkirModel.fromJson(e))
                                      .toList();
                                  setState(() {
                                    costRaja = costs;
                                    print(costRaja![0].costs);
                                    _isFinish = true;
                                    ongkir =
                                        costRaja![0].costs![0].cost![0].value!;
                                    print(ongkir);
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: e == selectedEkspedisi
                                          ? primaryColor
                                          : greyColor),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.toUpperCase(),
                                      style: primaryText.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: e == selectedEkspedisi
                                            ? primaryColor
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  _isFinish
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${costRaja![0].costs![0].service!}",
                                      style: primaryText.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${costRaja![0].costs![0].description!}",
                                      style: primaryText.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${rupiah.format(costRaja![0].costs![0].cost![0].value)}",
                                  style: primaryText.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              )
            : SizedBox(),
        const SizedBox(height: 30),

        cartProvider.carts.isNotEmpty
            ? checkout(context)
            : Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_bag_sharp,
                      color: redColor,
                      size: 100,
                    ),
                    Text(
                      "Keranjang Masih Kosong",
                      style: primaryText.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            "Keranjang",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget checkout(context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider tProvider = Provider.of<TransactionProvider>(context);

    var rupiah = NumberFormat.currency(name: "Rp. ", decimalDigits: 0);

    return Container(
      height: 244,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(cartProvider.getTotal()),
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item",
                style: primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${cartProvider.carts.length} item',
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ongkir (estimasi)",
                style: primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${rupiah.format(ongkir)}',
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total (with ppn)",
                style: primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(cartProvider.getTotal() + ongkir + kodeUnik),
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          GestureDetector(
            onTap: () async {
              if (selectedPayment != '' && ongkir != 0) {
                int ongkirDefault = selectedPayment == "MidTrans" ? ongkir : 0;

                tProvider.addTransactions(
                  context,
                  cartProvider.carts,
                  selectedPayment,
                  ongkirDefault,
                  kodeUnik,
                  cartProvider.getTotal() + kodeUnik + ongkirDefault,
                  cartProvider.carts.map((e) => e.toJson()).toList(),
                  alamat,
                  idCostumer,
                  nama,
                  email,
                  phone,
                  cartProvider.getTotal(),
                );

                setState(() {
                  cartProvider.carts.clear();
                  tProvider.transactions.clear();
                  ongkir = 0;
                });
              } else if (selectedPembayaran == "COD" && ongkir != 0) {
                int ongkirDefault = ongkir;

                tProvider.addTransactions(
                  context,
                  cartProvider.carts,
                  selectedPembayaran,
                  ongkirDefault,
                  kodeUnik,
                  cartProvider.getTotal() + kodeUnik + ongkirDefault,
                  cartProvider.carts.map((e) => e.toJson()).toList(),
                  alamat,
                  idCostumer,
                  nama,
                  email,
                  phone,
                  cartProvider.getTotal(),
                );

                setState(() {
                  cartProvider.carts.clear();
                  tProvider.transactions.clear();
                  ongkir = 0;
                });
              } else if (ongkir == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Silahkan pilih Ekspedisi Pengiriman",
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: redColor,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Silahkan pilih metode pembayaran",
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: redColor,
                  ),
                );
              }
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Proses Sekarang",
                  style: primaryText.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
