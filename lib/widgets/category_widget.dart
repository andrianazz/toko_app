import 'package:flutter/material.dart';
import 'package:toko_app/models/category_model.dart';

import '../theme.dart';

class CategoryWidget extends StatelessWidget {
  Function? onTap;
  CategoryModel? category;
  CategoryWidget({
    Key? key,
    this.onTap,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: 54,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                color: bgCategory.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(category!.imageUrl!),
                ),
              ),
            ),
            Container(
              width: 50,
              child: Text(
                category!.name!,
                style: primaryText.copyWith(fontSize: 9),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
