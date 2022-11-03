import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.width, required this.height, required this.color, required this.onTap, required this.text, required this.fontColor, required this.borderColor, });

  final double width;
  final double height;
  final Color color;
  final VoidCallback onTap;
  final String text;
  final Color fontColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
        ),
        child: Center(child: Text(text, style: globalTextStyle.copyWith(color: fontColor, fontSize: 4.w))),
      )
    );
  }
}