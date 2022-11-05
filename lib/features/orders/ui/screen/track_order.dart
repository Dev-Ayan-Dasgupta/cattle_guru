import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/orders/ui/widgets/order_tile.dart';
import 'package:cattle_guru/features/orders/ui/widgets/tracking_status_checkpoints.dart';
import 'package:cattle_guru/models/order_model.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Track Order", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Icon(Icons.menu_rounded, size: 5.w, color: white,)),
        ),
        actions: [
          InkWell(
            onTap: PhoneCall.makingPhoneCall,
            child: Icon(Icons.phone_rounded, size: 5.w, color: white)),
          SizedBox(width: 5.w,),
          InkWell(
            onTap: LaunchWhatsapp.whatsappLaunch,
            child: SizedBox(
              width: 5.w,
              height: 5.w,
              child: const Image(image: AssetImage("./assets/images/whatsapp_logo.png"))),
          ),
          SizedBox(width: 5.w,),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 2.5.h,),
                  SizedBox(
                    width: 100.w,
                    height: 22.5.w,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: currentOrder.order.length,
                            itemBuilder: (context, index){
                              return OrderTile(
                                onTap: (){}, 
                                imgUrl: currentOrder.order[index].product.imgUrls[0], 
                                productName: currentOrder.order[index].product.name, 
                                qty: currentOrder.order[index].qty, 
                                productPrice: currentOrder.order[index].product.price, 
                                productDeliveryDays: currentOrder.order[index].product.deliveryDays, 
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
                  SizedBox(height: 1.h,),
                  CheckPoint(
                    isConfirmed: true, 
                    isDispatched: true, 
                    isDelivered: false,
                    currentStatus: 1,
                    orderConfirmedDate: DateTime.now(),
                    orderDispatchedDate: DateTime.now().add(Duration(days: currentOrder.order[0].product.dispatchDays)),
                    orderDeliveryDate: DateTime.now().add(Duration(days: currentOrder.order[0].product.deliveryDays)),
                    // ,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: lightRed, onTap: (){}, text: "Cancel Order", fontColor: red, borderColor: red),
                  SizedBox(height: 2.h,),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index){
          if(index == 0){
            Navigator.pushNamed(context, home);
          }
          if(index == 3){
            Navigator.pushNamed(context, myCart);
          }
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: orangeLight,
        unselectedItemColor: white,
        selectedLabelStyle: globalTextStyle,
        unselectedLabelStyle: globalTextStyle,
        items: items,
        backgroundColor: primary,
      ),
    );
  }
}