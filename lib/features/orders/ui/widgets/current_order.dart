import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/orders/ui/screen/track_order.dart';
import 'package:cattle_guru/features/orders/ui/widgets/order_tile.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class CurrentOrder extends StatelessWidget {
  const CurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h,),
                  Text(DateFormat.yMMMMEEEEd().format(currentOrder.date), style: globalTextStyle.copyWith(color: grey, fontSize: 3.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h,),
                  SizedBox(
                    width: 100.h,
                    height: (22.5.w)*cartItems.length,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index){
                              return OrderTile(
                                onTap: (){},
                                imgUrl: cartItems[index].product.imgUrls[0], 
                                productName: cartItems[index].product.name, 
                                qty: cartItems[index].qty, 
                                productPrice: cartItems[index].product.price, 
                                productDeliveryDays: cartItems[index].product.deliveryDays,
                                date: currentOrder.date,
                              );
                            }
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Row(
                    children: [
                      Text("Amount: ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                      Text(currentOrder.amount.toString(), style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: lightRed, onTap: (){}, text: "Cancel Order", fontColor: red, borderColor: red),
                  SizedBox(height: 2.h,),
                  CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TrackOrderScreen(order: currentOrder)));
                  }, text: "Track Order", fontColor: white, borderColor: primary),
                  SizedBox(height: 2.h,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}