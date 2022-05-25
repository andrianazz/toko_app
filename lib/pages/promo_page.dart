import 'package:flutter/material.dart';
import 'package:toko_app/models/promo_model.dart';

import '../theme.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 30),
            header(context),
            const SizedBox(height: 30),
            content(),
          ],
        ),
      ),
    );
  }

  Widget header(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            "Promo",
            style: primaryText.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget content() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          children: mockPromo
              .map(
                (promo) => Container(
                  height: 163,
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      image: AssetImage(promo.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
