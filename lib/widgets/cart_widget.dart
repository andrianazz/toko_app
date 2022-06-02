import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toko_app/models/item_model.dart';
import 'package:toko_app/models/product_model.dart';
import 'package:toko_app/providers/cart_provider.dart';

import '../theme.dart';

class CartWidget extends StatefulWidget {
  ItemModel? items;

  CartWidget({Key? key, this.items}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

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
                    image: NetworkImage(widget.items!.imageUrl!),
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
                    width: 100,
                    child: Text(
                      widget.items!.name.toString(),
                      style: primaryText.copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: NumberFormat.simpleCurrency(
                              decimalDigits: 0, name: 'Rp. ')
                          .format(widget.items!.price),
                      style: primaryText.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.items!.quantity! >= 2) {
                      cartProvider.removeQuantity(widget.items!.id!, 1);
                    }
                  });
                },
                child: Container(
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
              ),
              const SizedBox(width: 14),
              Text(
                widget.items!.quantity!.toString(),
                style: primaryText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 14),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cartProvider.addQuantity(widget.items!.id!, 1);
                  });
                },
                child: Container(
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
