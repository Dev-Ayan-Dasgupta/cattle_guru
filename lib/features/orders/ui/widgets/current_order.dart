import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/orders/ui/screen/track_order.dart';
import 'package:cattle_guru/features/orders/ui/widgets/order_tile.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class CurrentOrder extends StatefulWidget {
  const CurrentOrder({super.key});

  @override
  State<CurrentOrder> createState() => _CurrentOrderState();
}
class _CurrentOrderState extends State<CurrentOrder> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('customers').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index){
                if(snapshot.hasData){
                  if(snapshot.data!.docs[index].get('uid') == currUserId) {
                    currentOrders = snapshot.data!.docs[index].get('currentOrders').toList();
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              currentOrders.isEmpty ?
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 22.5.h,),
                                      SizedBox(
                                        width: 45.w, 
                                        height: 27.w,
                                        child: const Image(image: AssetImage("./assets/images/empty_current_order.png"), fit: BoxFit.fill,),
                                      ),
                                      SizedBox(height: 2.h,),
                                      Center(
                                        child: SizedBox(
                                          width: 75.w,
                                          child: Text("You do not have any active orders, please browse our products and order them.", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,), textAlign: TextAlign.center,),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 22.h),
                                  Column(
                                    children: [
                                      CustomButton(width: 90.w, height: 15.w, color: primary, 
                                      onTap: (){
                                        Navigator.pushNamed(context, home);
                                      }, 
                                      text: "Browse Products", fontColor: white, borderColor: primary),
                                      SizedBox(height: 2.h,),
                                    ],
                                  ),
                                ],
                              ) 
                              : 
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    height: 63.h,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: currentOrders.length,
                                            itemBuilder: (context, index2) {
                                              num amt = currentOrders[index2]['amount'];
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 2.h,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(DateFormat.yMMMMEEEEd().format(currentOrders[index2]['date'].toDate()), style: globalTextStyle.copyWith(color: grey, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => TrackOrderScreen(order: currentOrders[index2], orderIndex: index2,)));
                                                        },
                                                        child: Container(
                                                          width: 15.w,
                                                          height: 7.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                                            color: primary,
                                                          ),
                                                          child: Center(child: Text("Track Order", style: globalTextStyle.copyWith(color: white, fontSize: 2.w, fontWeight: FontWeight.bold),)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  SizedBox(
                                                    width: 100.h,
                                                    height: (22.5.w)*currentOrders[index2]['order'].length,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: ListView.builder(
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemCount: currentOrders[index2]['order'].length,
                                                            itemBuilder: (context, index3){
                                                              return OrderTile(
                                                                onTap: (){},
                                                                imgUrl: currentOrders[index2]['order'][index3]['product']['imgUrls'][0], 
                                                                productName: currentOrders[index2]['order'][index3]['product']['name'], 
                                                                qty: currentOrders[index2]['order'][index3]['qty'], 
                                                                productPrice: currentOrders[index2]['order'][index3]['product']['price'].toDouble(), 
                                                                productDeliveryDays: currentOrders[index2]['order'][index3]['product']['deliveryDays'],
                                                                date: currentOrders[index2]['date'].toDate(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h,),
                                                  Row(
                                                    children: [
                                                      Text("Amount: ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                                      Text(amt.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true), style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      // CustomButton(width: 90.w, height: 15.w, color: lightRed, onTap: (){}, text: "Cancel Order", fontColor: red, borderColor: red),
                                      SizedBox(height: 1.h,),
                                      CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                                        Navigator.pushNamed(context, home);
                                      }, text: "Browse Products", fontColor: white, borderColor: primary),
                                      SizedBox(height: 2.h,),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        );
                      }
                    }
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              }
            ),
          ),
        );
      }
    }