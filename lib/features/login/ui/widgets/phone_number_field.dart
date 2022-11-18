import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key, required this.phoneController});

  final TextEditingController phoneController;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 15.w,
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(2.w)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          children: [
            Icon(Icons.phone, size: 4.w,),
            SizedBox(width: 3.w,),
            Text("+91", style: globalTextStyle.copyWith(fontSize: 4.w, fontWeight: FontWeight.bold),),
            SizedBox(width: 3.w,),
            Container(
              height: 6.w,
              width: 0.5,
              color: black,
            ),
            SizedBox(width: 3.w,),
            SizedBox(
              width: 59.w,
              child: TextField(
                controller: widget.phoneController,
                keyboardType: TextInputType.number,
                style: globalTextStyle.copyWith(fontSize: 4.w, color: black,),
                decoration: InputDecoration(
                  hintText: isEnglish ? "Enter your number here" : "यहां अपना नंबर दर्ज करें",
                  hintStyle: globalTextStyle.copyWith(fontSize: 4.w, color: grey,),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}