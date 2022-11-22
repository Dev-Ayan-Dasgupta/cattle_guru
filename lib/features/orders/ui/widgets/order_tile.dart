import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.onTap, required this.imgUrl, required this.productName, required this.qty, required this.productPrice, required this.productDeliveryDays, required this.date});

  final VoidCallback onTap;
  final String imgUrl;
  final String productName;
  final int qty;
  final double productPrice;
  final int productDeliveryDays;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: SizedBox(
          width: 100.w,
          height: isEnglish ? 21.w : 21.85.w,
          child: Row(
            children: [
              SizedBox(
                width: 21.w,
                height: 21.w,
                child: Image(image: AssetImage(imgUrl), fit: BoxFit.fill,),
              ),
              SizedBox(width: 5.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName, style: globalTextStyle.copyWith(color: black, fontSize: 3.5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.w,),
                  Text(isEnglish ? "Qty: $qty" : "संख्या: $qty", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                  SizedBox(height: 1.w,),
                  Text("₹ $productPrice", style: globalTextStyle.copyWith(color: black, fontSize: 3.5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.w,),
                  Text(isEnglish ? "Delivery by ${DateFormat.yMMMMEEEEd().format(date.add(Duration(days: productDeliveryDays)))}" : "${DateFormat.yMMMMEEEEd('hi').format(date.add(Duration(days: productDeliveryDays)))} तक डिलीवरी", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}