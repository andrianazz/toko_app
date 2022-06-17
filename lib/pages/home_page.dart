import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_app/models/category_model.dart';
import 'package:toko_app/models/product_model.dart';
import 'package:toko_app/pages/article_page.dart';
import 'package:toko_app/pages/detail_article_page.dart';
import 'package:toko_app/pages/detail_product_page.dart';
import 'package:toko_app/theme.dart';
import 'package:toko_app/widgets/best_sale_widget.dart';
import 'package:toko_app/widgets/category_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  String namaCostumer = '';

  @override
  void initState() {
    super.initState();
    getNama();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            background(),
            content(),
          ],
        ),
      ],
    );
  }

  Widget background() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget content() {
    CollectionReference promos = firestore.collection('promo');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        logo(),
        const SizedBox(height: 20),
        search(),
        const SizedBox(height: 30),
        promo(),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Kategori',
            style: primaryText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        category(),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produk Terbaru',
                style: primaryText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Selengkapnya",
                    style: primaryText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primaryColor,
                    size: 20,
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        //Harga Terbaik
        bestSale(),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Artikel Terbaru',
                style: primaryText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArticlePage(),
                      ));
                },
                child: Row(
                  children: [
                    Text(
                      "Selengkapnya",
                      style: primaryText.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: primaryColor,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        //Artikel
        SizedBox(
          width: double.infinity,
          height: 120,
          child: StreamBuilder<QuerySnapshot>(
            stream:
                promos.orderBy('date', descending: true).limit(5).snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs.map((e) {
                    Map<String, dynamic> promo =
                        e.data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailArticlePage(
                                      promo: promo,
                                    )));
                      },
                      child: Container(
                        width: 150,
                        height: 119,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Container(
                              width: 150,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: greyColor, width: 3),
                                image: DecorationImage(
                                  image: NetworkImage(promo['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              promo['title'],
                              style: primaryText.copyWith(
                                color: artikelColor,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Column(
                  children: [Text("No Data")],
                );
              }
            }),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget logo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Selamat Datang, \n${namaCostumer}",
        style: primaryText.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget search() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }

  Widget promo() {
    CollectionReference promos = firestore.collection('promo');
    return StreamBuilder<QuerySnapshot>(
        stream: promos.orderBy("date", descending: true).limit(5).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              items: snapshot.data!.docs.map((e) {
                Map<String, dynamic> promo = e.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailArticlePage(
                          promo: promo,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 400,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(promo['imageUrl']),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 170,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
            );
          } else {
            return SizedBox();
          }
        }));
  }

  Widget category() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryWidget(
                  onTap: () {
                    Navigator.pushNamed(context, '/productPage');
                  },
                  category: mockCategory[0]),
              CategoryWidget(category: mockCategory[1]),
              CategoryWidget(category: mockCategory[2]),
              CategoryWidget(category: mockCategory[3]),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryWidget(category: mockCategory[4]),
              CategoryWidget(category: mockCategory[5]),
              CategoryWidget(category: mockCategory[6]),
              CategoryWidget(category: mockCategory[7]),
            ],
          ),
        ],
      ),
    );
  }

  Widget bestSale() {
    CollectionReference products = firestore.collection('product');

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: products
            .orderBy('stok_tanggal', descending: true)
            .limit(5)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                scrollDirection: Axis.horizontal,
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

  Future<void> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString("name") ?? '';

    setState(() {
      namaCostumer = name;
    });
  }
}
