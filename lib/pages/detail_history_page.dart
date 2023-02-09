import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toko_app/models/transaction_model.dart';
import 'package:toko_app/pages/pay_midtrans_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class DetailHistoryPage extends StatefulWidget {
  TransactionModel? transaction;
  DetailHistoryPage({Key? key, this.transaction}) : super(key: key);

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String phone = "";

  @override
  void initState() {
    super.initState();
    getInit();
  }

  Future getInit() async {
    await firestore.collection('settings').doc('galerilam').get().then((value) {
      setState(() {
        phone = value['telepon'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          header(context),
          const SizedBox(height: 50),
          content(context),
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

  Widget content(context) {
    return Column(
      children: [
        Column(
          children: widget.transaction!.items!
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
                                Container(
                                  width: 150,
                                  child: Text(
                                    item.name!,
                                    style: primaryText.copyWith(
                                        fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          widget.transaction!.address!,
                          style: primaryText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
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
                        widget.transaction!.payment!,
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
                "Nomor Resi Pengiriman",
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
                        "Nomor Resi",
                        style: primaryText.copyWith(
                          fontSize: 12,
                          color: greyColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.transaction!.resi! == ''
                            ? 'Belum ada Resi'
                            : widget.transaction!.resi!,
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
                            ).format(widget.transaction!.ongkir!),
                            style: primaryText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  widget.transaction!.setOngkir == false ||
                          widget.transaction!.status! == "Bayar"
                      ? GestureDetector(
                          onTap: () async {
                            String total = NumberFormat.simpleCurrency(
                              decimalDigits: 0,
                              name: 'Rp. ',
                            ).format(widget.transaction!.totalTransaction!);
                            String ongkir = NumberFormat.simpleCurrency(
                              decimalDigits: 0,
                              name: 'Rp. ',
                            ).format(widget.transaction!.ongkir!);
                            await launch(
                                'https://wa.me/${phone}?text=Halo, Saya ingin nego ongkir dari ${ongkir} untuk transaksi ${widget.transaction!.id!} berjumlah ${widget.transaction!.totalProducts!} item dengan total = ${total}');
                          },
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Hubungi",
                                  style: primaryText.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        detail(context),
        SizedBox(height: 30),
      ],
    );
  }

  Widget detail(context) {
    CollectionReference transactions = firestore.collection("transactions");

    return Container(
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
                ).format(widget.transaction!.totalTransaction! -
                    widget.transaction!.ongkir!),
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
                "${widget.transaction!.totalProducts!} Item",
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
                ).format(widget.transaction!.ongkir!),
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
                ).format(widget.transaction!.totalTransaction!),
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Visibility(
            visible: (widget.transaction!.payment == "MidTrans" &&
                    widget.transaction!.status != "Selesai")
                ? true
                : false,
            child: GestureDetector(
              onTap: () async {
                String total = NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(widget.transaction!.totalTransaction!);

                await launch(
                    'https://wa.me/+628979036650?text=Halo, Saya ingin konfirmasi pembayaran yang sudah dilakukan untuk transaksi ${widget.transaction!.id!} berjumlah ${widget.transaction!.totalProducts!} item dengan total = ${total}');
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done_all,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Beritahu Penjual",
                      style: primaryText.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: (widget.transaction!.payment == "MidTrans" &&
                    widget.transaction!.redirectUrl != "")
                ? true
                : false,
            child: SizedBox(height: 10),
          ),
          Visibility(
            visible: (widget.transaction!.payment == "MidTrans" &&
                    widget.transaction!.redirectUrl != "")
                ? true
                : false,
            child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PayMidtransPage(
                      url: widget.transaction!.redirectUrl,
                    ),
                  ),
                );
              },
              child: Container(
                height: 56,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Pembayaran",
                      style: primaryText.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: (widget.transaction!.setOngkir == false &&
                    widget.transaction!.payment != "MidTrans")
                ? true
                : false,
            child: GestureDetector(
              onTap: () async {
                String total = NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(widget.transaction!.totalTransaction!);

                await launch(
                    'https://wa.me/+628979036650?text=Halo, Saya ingin nego ongkir untuk transaksi ${widget.transaction!.id!} berjumlah ${widget.transaction!.totalProducts!} item dengan total = ${total}');
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Hubungi Penjual",
                      style: primaryText.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: (widget.transaction!.setOngkir == true &&
                    widget.transaction!.status == "Bayar")
                ? true
                : false,
            child: GestureDetector(
              onTap: () async {
                String total = NumberFormat.simpleCurrency(
                  decimalDigits: 0,
                  name: 'Rp. ',
                ).format(widget.transaction!.totalTransaction!);
                await launch(
                    'https://wa.me/+628979036650?text=Halo, Saya ingin membayar untuk transaksi ${widget.transaction!.id!} berjumlah ${widget.transaction!.totalProducts!} item dengan total = ${total} \n\n'
                    'Berikut bukti pembayaran saya: \n\n');
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Kirim Bukti Bayar",
                    style: primaryText.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.transaction!.status == 'Selesai',
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Kembali ke Riwayat",
                    style: primaryText.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: (widget.transaction!.setOngkir == false) ? true : false,
            child: SizedBox(
              height: 10,
            ),
          ),
          Visibility(
            visible: (widget.transaction!.setOngkir == false &&
                    widget.transaction!.payment != "MidTrans")
                ? true
                : false,
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                          title: Text('Konfirmasi membatalkan transaksi'),
                          content: Text(
                              'Apa kamu yakin ingin menghapus Transaksi ini?'),
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
                                transactions
                                    .doc(widget.transaction!.id!)
                                    .delete();

                                Navigator.pop(context);
                                Navigator.pop(context);
                                setState(() {});
                              },
                            ),
                          ],
                        ));
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Batalkan Pemesanan",
                      style: primaryText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
