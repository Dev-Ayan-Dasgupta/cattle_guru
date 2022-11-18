import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class FilterLabel extends StatefulWidget {
  FilterLabel({super.key, required this.onTap, required this.isSelected, required this.text});

  final VoidCallback onTap;
  bool isSelected;
  final String text;

  @override
  State<FilterLabel> createState() => _FilterLabelState();
}

class _FilterLabelState extends State<FilterLabel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: Container(
          width: 20.w,
          height: 6.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            color: widget.isSelected ? primary : primaryLight,
          ),
          child: Center(child: Text(widget.text, style: globalTextStyle.copyWith(color: widget.isSelected ? white : black),),),
        ),
      ),
    );
  }
}