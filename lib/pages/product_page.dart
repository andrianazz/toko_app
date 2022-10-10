import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/models/product_model.dart';
import 'package:toko_app/pages/detail_product_page.dart';
import 'package:toko_app/theme.dart';
import 'package:toko_app/widgets/category_product_widget.dart';

import '../models/category_model.dart';

import '../widgets/best_sale_widget.dart';

class ProductPage extends StatefulWidget {
  String? name;
  ProductPage({Key? key, this.name}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  String searchText = '';

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
                        textCapitalization: TextCapitalization.sentences,
                        style: primaryText.copyWith(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        onTap: () {
                          setState(() {
                            searchController.clear();
                            searchText = '';
                            widget.name = null;
                          });
                        },
                        onChanged: (value) {
                          // ignore: unnecessary_null_comparison
                          if (value != '') {
                            Future.delayed(Duration(milliseconds: 1200), () {
                              setState(() {
                                searchText = value[0].toUpperCase() +
                                    value.substring(1).toLowerCase();
                              });
                            });
                            print(searchText);
                          } else {
                            setState(() {
                              searchController.clear();
                              searchText = '';
                              widget.name = null;
                            });
                          }
                        },
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
    CollectionReference tags = firestore.collection('tags');

    return SizedBox(
      width: double.infinity,
      height: 97,
      child: StreamBuilder<QuerySnapshot>(
        stream: tags.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((e) {
                CategoryModel cat =
                    CategoryModel.fromJson(e.data() as Map<String, dynamic>);

                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CategoryProductWidget(
                    onTap: () {
                      if (widget.name != cat.name) {
                        setState(() {
                          widget.name = cat.name!;
                          searchController.clear();
                        });
                      } else {
                        setState(() {
                          searchController.clear();
                          searchText = '';
                          widget.name = null;
                        });
                      }
                    },
                    category: cat,
                    isSelected: widget.name == cat.name,
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }

  Widget product() {
    CollectionReference products = firestore.collection("product");
    return SizedBox(
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: searchText.isNotEmpty
            ? products
                .where('nama',
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText + "z")
                // .where('sisa_stok', isGreaterThan: 0)
                .snapshots()
            : widget.name == null
                ? products.where('sisa_stok', isGreaterThan: 0).snapshots()
                : products
                    // .where('sisa_stok', isGreaterThan: 0)
                    .where('tag', arrayContains: widget.name)
                    .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Wrap(
                alignment: WrapAlignment.center,
                children: snapshot.data!.docs.map((e) {
                  Map<String, dynamic> product =
                      e.data() as Map<String, dynamic>;
                  ProductModel productModel = ProductModel.fromJson(product);

                  if (product['sisa_stok'] >= 1) {
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
                  } else {
                    return SizedBox();
                  }
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
