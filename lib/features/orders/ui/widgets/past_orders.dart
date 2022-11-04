import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/orders/ui/widgets/past_order_tile.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class PastOrders extends StatelessWidget {
  const PastOrders({super.key});

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
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 100.w,
                    height: 60.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: previousOrders.length,
                            itemBuilder: (context, index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(DateFormat.yMMMMEEEEd().format(previousOrders[index].date), style: globalTextStyle.copyWith(color: grey, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 1.h,),
                                  SizedBox(
                                    width: 100.w,
                                    height: (22.5.w)*previousOrders[index].order.length,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: previousOrders[index].order.length,
                                            itemBuilder: (context, index2){
                                              return PastOrderTile(
                                                onTap: (){}, 
                                                imgUrl: previousOrders[index].order[index2].product.imgUrls[0], 
                                                productName: previousOrders[index].order[index2].product.name, 
                                                qty: previousOrders[index].order[index2].qty, 
                                                productPrice: previousOrders[index].order[index2].product.price, 
                                                productDeliveryDays: previousOrders[index].order[index2].product.deliveryDays,
                                                date: previousOrders[index].date,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Text("Amount: ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                      Text(previousOrders[index].amount.toString(), style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 1.5.h),
                                ],
                              );
                            }
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Browse Products", fontColor: white, borderColor: primary),
                  SizedBox(height: 2.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}