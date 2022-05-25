import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../theme.dart';

class CategoryProductWidget extends StatelessWidget {
  Function? onTap;
  CategoryModel? category;
  bool isSelected;
  CategoryProductWidget(
      {Key? key, this.onTap, this.category, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Column(
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: bgCategory.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.transparent,
              ),
              image: DecorationImage(
                image: AssetImage(category!.imageUrl!),
              ),
            ),
          ),
          Text(
            category!.name!,
            style: primaryText.copyWith(
              fontSize: 12,
              color: isSelected ? primaryColor : greyColor,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          isSelected == true
              ? Container(
                  width: 66,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
