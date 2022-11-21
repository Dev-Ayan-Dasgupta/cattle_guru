import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({super.key, required this.controller, required this.hintText, required this.label, required this.keyboardType, required this.width, this.onChanged});

  final double width;
  final TextEditingController controller;
  final String hintText;
  final String label;
  final TextInputType keyboardType;
  void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 15.w,
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        style: globalTextStyle.copyWith(fontSize: 4.w, color: black,),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            borderSide: const BorderSide(color: primary, width: 1)
          ),
          hintText: widget.hintText,
          hintStyle: globalTextStyle.copyWith(fontSize: 4.w, color: grey,),
          label: Text(widget.label, style: globalTextStyle.copyWith(fontSize: 4.w, color: primary,),),
          
        ),
      ),
    );
  }
}