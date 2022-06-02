import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app/models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/userApp_provider.dart';
import '../theme.dart';

class DetailProductPage extends StatefulWidget {
  Map<String, dynamic>? product;
  DetailProductPage({Key? key, this.product}) : super(key: key);

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          image(),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          content(context),
        ],
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  Widget bottomNavBar(context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    UserAppProvider userProvider = Provider.of<UserAppProvider>(context);

    return Container(
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 22),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 4,
            blurRadius: 4,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (qty >= 2) {
                  qty = qty - 1;
                }
              });
            },
            child: Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Icon(
                  Icons.remove,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${qty}',
                style: primaryText.copyWith(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                qty = qty + 1;
              });
            },
            child: Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  cartProvider.addCartWithQty(
                    ProductModel.fromJson(
                        widget.product as Map<String, dynamic>),
                    qty,
                    context,
                  );

                  Navigator.pop(context);

                  qty = 1;
                });
              },
              child: Container(
                width: double.infinity,
                height: 49,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "+ Keranjang",
                    style: primaryText.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget image() {
    return Container(
      width: double.infinity,
      height: 326,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.product!['imageUrl']),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget content(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 360,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Tag
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.product!['nama'],
                style: primaryText.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                text: TextSpan(
                  text: 'Rp ${widget.product!['harga_jual'].toString()}',
                  style: primaryText.copyWith(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: '/ kg',
                      style: primaryText.copyWith(
                        fontSize: 14,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "Deskripsi",
                        style: primaryText.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 81,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: greyColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.product!['deskripsi'],
                style: primaryText.copyWith(fontSize: 13),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
