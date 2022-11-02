import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductCategoryTile extends StatelessWidget {
  const ProductCategoryTile({super.key, required this.onTap, required this.width, required this.imageUrl, required this.productCategoryName});

  final VoidCallback onTap;
  final double width;
  final String imageUrl;
  final String productCategoryName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            // Container(
            //   width: width,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.fill),
            //   ),
            // ),
            CircleAvatar(
              foregroundImage: AssetImage(imageUrl),
              radius: 27.75,
            ),
            SizedBox(height: 1.h,),
            Text(productCategoryName, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}