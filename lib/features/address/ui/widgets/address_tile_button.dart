import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AddressTileButton extends StatelessWidget {
  const AddressTileButton({super.key, required this.onTap, required this.buttonColor, required this.itemColor, required this.iconData, required this.buttonText});

  final VoidCallback onTap;
  final Color buttonColor;
  final Color itemColor;
  final IconData iconData;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 1.w),
        child: Container(
          width: (77/3).w,
          height: 8.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            color: buttonColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 3.w, color: itemColor,),
              SizedBox(width: 2.w,),
              Text(buttonText, style: globalTextStyle.copyWith(color: itemColor, fontSize: 3.w),)
            ],
          ),
        ),
      ),
    );
  }
}