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

  List payments = ["TUNAI", 'EDC', 'DANA', 'GRAB', 'OVO', 'TRANSFER'];
  String selectedPayment = "TUNAI";

  @override
  void initState() {
    super.initState();
    getId();
    getAlamat();
  }

  String idCostumer = '';
  String alamat = '';

  Future<void> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id") ?? '';

    setState(() {
      idCostumer = id;
    });
  }

  Future<void> getAlamat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String address = pref.getString("alamat") ?? '';
    String kecamatan = pref.getString("kecamatan") ?? '';
    String kelurahan = pref.getString("kelurahan") ?? '';
    String kota = pref.getString("kota") ?? '';
    String provinsi = pref.getString("provinsi") ?? '';

    setState(() {
      alamat = '$address, $kecamatan, $kelurahan, $kota, $provinsi';
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
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: payments
                      .map((pay) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPayment = pay;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: pay == selectedPayment
                                        ? primaryColor
                                        : greyColor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                pay,
                                style: primaryText.copyWith(
                                  fontSize: 18,
                                  color: pay == selectedPayment
                                      ? primaryColor
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
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
                ).format(cartProvider.getTotal() + 0 + Random().nextInt(499)),
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          GestureDetector(
            onTap: () {
              setState(() {
                tProvider.addTransactions(
                  context,
                  cartProvider.carts,
                  selectedPayment,
                  0,
                  cartProvider.getTotal(),
                  cartProvider.carts.map((e) => e.toJson()).toList(),
                  alamat,
                  idCostumer,
                );

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
