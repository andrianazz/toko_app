import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class BestSaleWidget extends StatelessWidget {
  Function? onTap;
  Map<String, dynamic>? product;
  BestSaleWidget({
    Key? key,
    this.onTap,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157,
      height: 220,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 4,
            ),
          ]),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            child: Container(
              height: 131,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(product!['imageUrl'][0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product!['nama'],
                    style: primaryText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(
                          decimalDigits: 0,
                          name: 'Rp. ',
                        ).format(product!['harga_jual']),
                        style: primaryText.copyWith(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${product!['deskripsi'] ?? 'Tidak ada Deskripsi'}",
                    style: primaryText.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: greyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
