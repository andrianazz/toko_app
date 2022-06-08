import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toko_app/pages/detail_article_page.dart';
import 'package:toko_app/theme.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference article = firestore.collection("promo");

    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Artikel Terbaru",
                style: primaryText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: article
                    .limit(1)
                    .orderBy("id", descending: true)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.docs.map((e) {
                        Map<String, dynamic> artikel =
                            e.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailArticlePage(
                                  promo: artikel,
                                ),
                              ),
                            );
                          },
                          child: Container(
                              height: 250,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: artikelColor,
                                      spreadRadius: 3,
                                      offset: Offset(3, 3),
                                      blurRadius: 8,
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    margin: EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(artikel['imageUrl']),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    artikel['title'],
                                    style: primaryText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Spacer(),
                                  Text(
                                    "Inisiatif GBN ini ingin mengajak masyarakat lebih mencintai dan memilih produk buah asli tanah air, yang ditawarkan lewat beragam promo menarik belanja buah segar lokal selama periode 9-31 Agustus 2021.  Blibli merupakan salah satu e-commerce yang bekerja sama dengan GBN 2021 dan turut serta menyelenggarakan kegiatan bazar secara online yang ditawarkan melalui display di laman promosi Galeri Indonesia x Gerakan Buah Nusantara agar pelanggan dapat dengan mudah membeli buah segar nusantara dengan kualitas baik dengan harga bersahabat.  “Ini bukan kali pertama, Blibli mendukung upaya pemerintah dalam menggerakkan masyarakat untuk Bangga Buatan Indonesia, yang kali ini berupa rangkaian Gelar Buah Nasional 2021. Dengan mendukung program GBN 2021, Blibli ingin mengajak pelanggan",
                                    style: primaryText.copyWith(
                                      fontSize: 12,
                                      color: artikelColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )),
                        );
                      }).toList(),
                    );
                  } else {
                    return Column(
                      children: [
                        Text("No Data"),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 30),
              Text(
                "Semua Artikel",
                style: primaryText.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                  stream: article.orderBy("id", descending: true).snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs.map((e) {
                          Map<String, dynamic> artikel =
                              e.data() as Map<String, dynamic>;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailArticlePage(
                                    promo: artikel,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: artikelColor,
                                      spreadRadius: 3,
                                      offset: Offset(3, 3),
                                      blurRadius: 8,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          artikel['title'],
                                          style: primaryText.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(
                                            artikel['description'],
                                            style: primaryText.copyWith(
                                              fontSize: 12,
                                              color: artikelColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(artikel['imageUrl']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
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
            ],
          ),
        ),
      ),
    );
  }
}
