import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toko_app/models/transaction_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../theme.dart';

class DetailHistoryPage extends StatelessWidget {
  TransactionModel? transaction;
  DetailHistoryPage({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          header(context),
          const SizedBox(height: 50),
          content(),
        ],
      ),
    );
  }

  Widget header(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            "Detail Pesanan",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        Column(
          children: transaction!.items!
              .map((item) => Container(
                    width: double.infinity,
                    height: 91,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: cartColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 73,
                              height: 73,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(item.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  item.name!,
                                  style: primaryText.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: NumberFormat.simpleCurrency(
                                      decimalDigits: 0,
                                      name: 'Rp. ',
                                    ).format(item.price!),
                                    style: primaryText.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          "${item.quantity} item",
                          style: primaryText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cartColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Alamat",
                style: primaryText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondaryColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.location_on_rounded,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alamat",
                        style: primaryText.copyWith(
                          fontSize: 12,
                          color: greyColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        transaction!.address!,
                        style: primaryText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cartColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Pembayaran",
                style: primaryText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondaryColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_wallet_rounded,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metode Pembayaran",
                        style: primaryText.copyWith(
                          fontSize: 12,
                          color: greyColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        transaction!.payment!,
                        style: primaryText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cartColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ongkos Kirim",
                style: primaryText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.delivery_dining,
                                color: primaryColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ongkos Kirim",
                            style: primaryText.copyWith(
                              fontSize: 12,
                              color: greyColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            NumberFormat.simpleCurrency(
                              decimalDigits: 0,
                              name: 'Rp. ',
                            ).format(transaction!.ongkir!),
                            style: primaryText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      String total = NumberFormat.simpleCurrency(
                        decimalDigits: 0,
                        name: 'Rp. ',
                      ).format(transaction!.totalTransaction!);
                      String ongkir = NumberFormat.simpleCurrency(
                        decimalDigits: 0,
                        name: 'Rp. ',
                      ).format(transaction!.ongkir!);
                      await launch(
                          'https://wa.me/+628979036650?text=Halo, Saya ingin nego ongkir dari ${ongkir} untuk transaksi ${transaction!.id!} berjumlah ${transaction!.totalProducts!} item dengan total = ${total}');
                    },
                    child: Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Hubungi",
                          style: primaryText.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        detail(),
        SizedBox(height: 30),
      ],
    );
  }

  Widget detail() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ).format(transaction!.totalTransaction! - transaction!.ongkir!),
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
                "${transaction!.totalProducts!} Item",
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
                "Ongkos Kirim",
                style: primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(transaction!.ongkir!),
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
                "Total",
                style: primaryText.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(transaction!.totalTransaction!),
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Visibility(
            visible: (transaction!.ongkir == 0) ? false : true,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Bayar Sekarang",
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
