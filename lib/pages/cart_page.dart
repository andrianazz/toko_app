import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_app/providers/cart_provider.dart';
import 'package:toko_app/theme.dart';
import 'package:toko_app/widgets/cart_widget.dart';
import '../providers/transaction_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int kodeUnik = Random().nextInt(499);

  List payments = [
    'Dana',
    "GoPay",
    'ShopeePay',
    'OVO',
    'MidTrans',
    "BNI",
    "BRI"
  ];
  String selectedPayment = "";

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
      nama = '$nameString';
      email = '$emailString';
      phone = '$phoneString';
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

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
                "?",
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
                ).format(cartProvider.getTotal() + 0 + kodeUnik),
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
              tProvider.addTransactions(
                  context,
                  cartProvider.carts,
                  selectedPayment,
                  0,
                  kodeUnik,
                  cartProvider.getTotal() + kodeUnik + 0,
                  cartProvider.carts.map((e) => e.toJson()).toList(),
                  alamat,
                  idCostumer,
                  nama,
                  email,
                  phone);

              setState(() {
                cartProvider.carts.clear();
                tProvider.transactions.clear();
              });
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
