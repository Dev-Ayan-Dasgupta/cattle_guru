import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({super.key, required this.items, required this.dropdownvalue});

  final List items;
  int dropdownvalue;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: widget.dropdownvalue,
        style: globalTextStyle.copyWith(color: grey, fontWeight: FontWeight.bold),
        iconEnabledColor: grey,
        items: widget.items.map((items) => DropdownMenuItem(value: items, child: Text(items.toString()))).toList(), 
        onChanged: (newValue){
          setState(() {
            widget.dropdownvalue = newValue as int;
            buyNowValue = widget.dropdownvalue*auxBuyNowValue;
          });
        },
      ),
    );
  }
}