import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toko_app/models/history_model.dart';
import 'package:toko_app/models/transaction_model.dart';

import '../theme.dart';

class HistoryWidget extends StatelessWidget {
  Function? onTap;

  TransactionModel? transaction;
  HistoryWidget({Key? key, this.onTap, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = transaction!.date!;
    String convertTime =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year.toString()} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: 93,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cartColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction!.totalProducts} Produk',
                    style: primaryText.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    convertTime,
                    style: primaryText.copyWith(color: const Color(0xff757575)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    NumberFormat.simpleCurrency(
                      decimalDigits: 0,
                      name: 'Rp. ',
                    ).format(transaction!.totalTransaction!),
                    style: primaryText.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Chip(
              label: Text(
                transaction!.status!,
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              backgroundColor: transaction!.status! == 'berhasil'
                  ? primaryColor
                  : transaction!.status! == 'proses'
                      ? blueColor
                      : redColor,
            ),
          ],
        ),
      ),
    );
  }
}
