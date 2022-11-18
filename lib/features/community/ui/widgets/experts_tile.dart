import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ExpertsTile extends StatelessWidget {
  const ExpertsTile({super.key, required this.expertImgUrl});

  final String expertImgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Container(
        width: 25.w,
        height: 25.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.w)),
          image: DecorationImage(image: NetworkImage(expertImgUrl), fit: BoxFit.fill),
        ),
      ),
    );
  }
}