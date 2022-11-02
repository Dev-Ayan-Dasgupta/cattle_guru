import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomTextLabel extends StatelessWidget {
  const CustomTextLabel({super.key, required this.width, required this.height, required this.text, required this.color, required this.fontColor});

  final double width;
  final double height;
  final String text;
  final Color color;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(1.w)),
          color: color,
        ),
        child: Center(
          child: Text(text, style: globalTextStyle.copyWith(fontSize: 3.w, color: fontColor),),
        ),
      ),
    );
  }
}