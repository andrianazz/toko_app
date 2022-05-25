import 'package:flutter/material.dart';
import 'package:toko_app/models/cart_model.dart';

import '../theme.dart';

class CartWidget extends StatelessWidget {
  CartModel? cart;
  CartWidget({Key? key, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 91,
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: cartColor),
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
                    image: NetworkImage(cart!.product!.imageUrl!),
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
                    cart!.product!.name!,
                    style: primaryText.copyWith(fontWeight: FontWeight.w700),
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Rp ${cart!.product!.price!.toString()}',
                        style: primaryText.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                        children: [
                          TextSpan(
                              text: "/ Kg",
                              style: primaryText.copyWith(
                                  fontSize: 10, color: greyColor))
                        ]),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: secondaryColor,
                ),
                child: const Center(
                  child: Icon(Icons.remove, color: primaryColor),
                ),
              ),
              const SizedBox(width: 14),
              Text(
                cart!.quantity!.toString(),
                style: primaryText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 14),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
