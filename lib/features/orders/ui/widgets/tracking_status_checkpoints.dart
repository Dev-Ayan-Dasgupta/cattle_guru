import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class CheckPoint extends StatelessWidget {
  const CheckPoint({super.key, required this.isConfirmed, required this.isDispatched, required this.isDelivered, required this.currentStatus, required this.orderConfirmedDate, required this.orderDispatchedDate, required this.orderDeliveryDate});

  final bool isConfirmed;
  final bool isDispatched;
  final bool isDelivered;
  final int currentStatus;
  final DateTime orderConfirmedDate;
  final DateTime orderDispatchedDate;
  final DateTime orderDeliveryDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isConfirmed ? primary : transparent,
                border: Border.all(color: black),
              ),
            ),
            Container(
              width: 1,
              height: 35.w,
              color: black,
            ),
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDispatched ? primary : transparent,
                border: Border.all(color: black),
              ),
            ),
            Container(
              width: 1,
              height: 35.w,
              color: black,
            ),
            Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDelivered ? primary : transparent,
                border: Border.all(color: black),
              ),
            ),
          ],
        ),
        SizedBox(width: 15.w,),
        Column(
          children: [
            Column(
              children: [
                Container(
                  width: currentStatus == 0 ? 25.w : 20.w,
                  height: currentStatus == 0 ? 25.w : 20.w,
                  foregroundDecoration: BoxDecoration(
                    color: isConfirmed ? transparent : grey,
                    backgroundBlendMode: BlendMode.saturation,
                  ),
                  child: const Image(image: AssetImage("./assets/images/order_confirmed.png"), fit: BoxFit.fill,),
                ),
                SizedBox(height: 1.w,),
                Text(isConfirmed ? isEnglish ? "Order Confirmed" : "ऑर्डर की पुष्टि की गई" : isEnglish ? "Confirmation Pending" : "पुष्टि लंबित", style: globalTextStyle.copyWith(color: black, fontSize: currentStatus == 0 ? 3.w : 2.5.w, fontWeight: FontWeight.bold),),
                SizedBox(height: 1.w,),
                Text(isConfirmed ? DateFormat.yMMMMEEEEd().format(orderConfirmedDate) : "", style: globalTextStyle.copyWith(color: black, fontSize: currentStatus == 0 ? 2.5.w : 2.w,),),
              ],
            ),
            SizedBox(height: 7.5.w,),
            Column(
              children: [
                Container(
                  width: currentStatus == 1 ? 35.w : 30.w,
                  height: currentStatus == 1 ? 25.w : 20.w,
                  foregroundDecoration: BoxDecoration(
                    color: isDispatched ? transparent : grey,
                    backgroundBlendMode: BlendMode.saturation,
                  ),
                  child: const Image(image: AssetImage("./assets/images/order_dispatched.png"), fit: BoxFit.fill,),
                ),
                SizedBox(height: 2.w,),
                Text(isDispatched ? isEnglish ? "Dispatched" : "भेजा गया" : isEnglish ? "Dispatch" : "प्रेषण", style: globalTextStyle.copyWith(color: black, fontSize: currentStatus == 1 ? 3.5.w : 2.5.w, fontWeight: FontWeight.bold),),
                SizedBox(height: 1.w,),
                Text(isDispatched ? isEnglish ? "On ${DateFormat.yMMMMEEEEd().format(orderDispatchedDate)}" : "${DateFormat.yMMMMEEEEd().format(orderDispatchedDate)} को" : isEnglish ? "By ${DateFormat.yMMMMEEEEd().format(orderDispatchedDate)}" : "${DateFormat.yMMMMEEEEd().format(orderDispatchedDate)} तक", style: globalTextStyle.copyWith(color: black, fontSize: currentStatus == 1 ? 2.5.w : 2.w,),),
              ],
            ),
            SizedBox(height: 8.5.w,),
            Column(
              children: [
                Container(
                  width: currentStatus == 2 ? 25.w : 20.w,
                  height: currentStatus == 2 ? 20.w : 15.w,
                  foregroundDecoration: BoxDecoration(
                    color: isDelivered ? transparent : grey,
                    backgroundBlendMode: BlendMode.saturation,
                  ),
                  child: const Image(image: AssetImage("./assets/images/order_delivered.png"), fit: BoxFit.fill,),
                ),
                SizedBox(height: 2.w,),
                Text(isDelivered ? isEnglish ? "Delivered" : "पहुंचा दिया" : isEnglish ? "Delivery" : "वितरण", style: globalTextStyle.copyWith(color: black, fontSize: currentStatus == 2 ? 3.5.w : 2.5.w, fontWeight: FontWeight.bold),),
                SizedBox(height: 1.w,),
                Text(isDelivered ? isEnglish ? "On ${DateFormat.yMMMMEEEEd().format(orderDeliveryDate)}" : "${DateFormat.yMMMMEEEEd('hi').format(orderDeliveryDate)} को" : isEnglish ? "By ${DateFormat.yMMMMEEEEd().format(orderDeliveryDate)}" : "${DateFormat.yMMMMEEEEd('hi').format(orderDeliveryDate)} तक", style: globalTextStyle.copyWith(color: black, fontSize: currentStatus == 2 ? 2.5.w : 2.w,),),
              ],
            ),
          ],
        ),
      ],
    );
  }
}