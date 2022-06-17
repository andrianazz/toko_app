import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/models/product_model.dart';
import 'package:toko_app/pages/detail_product_page.dart';
import 'package:toko_app/theme.dart';
import 'package:toko_app/widgets/category_product_widget.dart';

import '../models/category_model.dart';

import '../widgets/best_sale_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  late int indexCategory = -1;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              search(),
              const SizedBox(height: 12),
              category(),
              Container(
                width: double.infinity,
                height: 1,
                color: greyColor,
              ),
              product(),
            ],
          )
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
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
                color: secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 19),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset('assets/search.png'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: primaryText.copyWith(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: InputBorder.none,
                          hintText: 'Pencarian',
                          hintStyle: primaryText.copyWith(
                            color: greyColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget category() {
    return SizedBox(
      width: double.infinity,
      height: 97,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: mockCategory.map((category) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: CategoryProductWidget(
                  onTap: () {
                    setState(() {
                      selectedIndex = category.id!;
                    });
                  },
                  category: category,
                  isSelected: selectedIndex == category.id!,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget product() {
    CollectionReference products = firestore.collection("product");
    return SizedBox(
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: products.orderBy('nama').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Wrap(
                alignment: WrapAlignment.center,
                children: snapshot.data!.docs.map((e) {
                  Map<String, dynamic> product =
                      e.data() as Map<String, dynamic>;
                  ProductModel productModel = ProductModel.fromJson(product);

                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: BestSaleWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProductPage(
                              product: productModel,
                            ),
                          ),
                        );
                      },
                      product: product,
                    ),
                  );
                }).toList());
          } else {
            return Column(
              children: [
                Text('No data'),
              ],
            );
          }
        }),
      ),
    );
  }
}
