import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatefulWidget {
  const CustomPinput({super.key, required this.onSubmitted, required this.pinController,});

  final Function(String?) onSubmitted;
  final TextEditingController pinController;

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      onSubmitted: widget.onSubmitted,
      controller: widget.pinController,
      defaultPinTheme: PinTheme(
        width: 13.33.w,
        height: 13.33.w,
        textStyle: globalTextStyle,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryLight),
          borderRadius: BorderRadius.circular(10),
          color: primaryLight,
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 13.33.w,
        height: 13.33.w,
        textStyle: globalTextStyle.copyWith(fontWeight: FontWeight.bold, color: primary,),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primary),
          borderRadius: BorderRadius.circular(10),
          color: primaryLight,
        ),
      ),
    );
  }
}