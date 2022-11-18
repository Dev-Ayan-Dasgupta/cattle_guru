import 'package:cattle_guru/features/address/ui/widgets/address_tile_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({super.key, required this.onTap, 
  // required this.cardColor, 
  // required this.fontColor, 
  required this.isDefault, required this.name, required this.address, required this.onEditTap, required this.onDefaultTap, required this.onRemoveTap});

  final VoidCallback onTap;
  // final Color cardColor;
  // final Color fontColor;
  final bool isDefault;
  final String name;
  final String address;
  final VoidCallback onEditTap;
  final VoidCallback onDefaultTap;
  final VoidCallback onRemoveTap;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.5.w),
        child: Container(
          width: 100.w,
          height: 32.w,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.w)),
            color: widget.isDefault ? primary : primaryLight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: globalTextStyle.copyWith(color: widget.isDefault ? white : black, fontSize: 4.w, fontWeight: FontWeight.bold),),
              SizedBox(height: 2.w,),
              Text(widget.address, style: globalTextStyle.copyWith(color: widget.isDefault ? white : black, fontSize: 3.w,), maxLines: 1, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 2.w,),
              Row(
                children: [
                  AddressTileButton(onTap: widget.onEditTap, buttonColor: widget.isDefault ? primaryDark : primaryLight, itemColor: widget.isDefault ? white : black, iconData: Icons.edit_rounded, buttonText: isEnglish ? "Edit" : "संपादित करें"),
                  AddressTileButton(onTap: widget.onDefaultTap, buttonColor: widget.isDefault ? primaryDark : primaryLight, itemColor: widget.isDefault ? white : black, iconData: Icons.check_rounded, buttonText: isEnglish ? "Default" : "वर्तमान"),
                  AddressTileButton(onTap: widget.onRemoveTap, buttonColor: widget.isDefault ? primaryDark : primaryLight, itemColor: widget.isDefault ? white : black, iconData: Icons.delete_rounded, buttonText: isEnglish ? "Remove" : "हटा दे"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}