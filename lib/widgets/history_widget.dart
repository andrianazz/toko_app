import 'package:flutter/material.dart';
import 'package:toko_app/models/history_model.dart';

import '../theme.dart';

class HistoryWidget extends StatelessWidget {
  Function? onTap;
  HistoryModel? history;
  HistoryWidget({Key? key, this.onTap, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = history!.time!;
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
            Container(
              width: 73,
              height: 73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(history!.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${history!.item!.toString()} Produk',
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
                    'Rp. ${history!.total!.toString()}',
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
                history!.status!.name,
                style: primaryText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              backgroundColor: history!.status!.name == 'berhasil'
                  ? primaryColor
                  : history!.status!.name == 'proses'
                      ? blueColor
                      : redColor,
            ),
          ],
        ),
      ),
    );
  }
}
