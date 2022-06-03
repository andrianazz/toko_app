import 'package:flutter/material.dart';
import 'package:toko_app/theme.dart';

class DetailArticlePage extends StatelessWidget {
  Map<String, dynamic>? promo;
  DetailArticlePage({Key? key, this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel Terkait"),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  promo!['title'],
                  style: primaryText.copyWith(
                    fontSize: 32,
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(promo!['imageUrl']),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  promo!['description'],
                  style: primaryText.copyWith(
                    color: artikelColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
