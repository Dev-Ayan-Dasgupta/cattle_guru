import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({super.key});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {

  bool isCod = true;

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Payment Options" : "भुगतान विकल्प", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Icon(Icons.menu_rounded, size: 7.5.w, color: white,)),
        ),
        actions: [
          InkWell(
            onTap: PhoneCall.makingPhoneCall,
            child: Icon(Icons.phone_rounded, size: 7.5.w, color: white)),
          SizedBox(width: 7.5.w,),
          InkWell(
            onTap: LaunchWhatsapp.whatsappLaunch,
            child: SizedBox(
              width: 7.5.w,
              height: 7.5.w,
              child: const Image(image: AssetImage("./assets/images/whatsapp_logo.png"))),
          ),
          SizedBox(width: 7.5.w,),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h,),
                  Center(
                    child: SizedBox(
                      width: 40.w,
                      height: 30.w,
                      child: const Image(image: AssetImage("./assets/images/payment_mode.png"), fit: BoxFit.fill,),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Text(isEnglish? "Please select a mode of payment" : "कृपया भुगतान का एक तरीका चुनें", style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 2.h,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isCod= true;
                      });
                    },
                    child: Container(
                      width: 90.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                        color: isCod ? primary : primaryLight,
                      ),
                      child: Center(
                        child: Text(isEnglish ? "Cash on Delivery (COD)" : "डिलवरी पर नकदी", style: globalTextStyle.copyWith(color: isCod ? white : black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isCod = false;
                      });
                    },
                    child: Container(
                      width: 90.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.all(Radius.circular(2.w)),
                        color: isCod ? primaryLight : primary,
                      ),
                      child: Center(
                        child: Text(isEnglish ? "Online Payment" : "ऑनलाइन भुगतान", style: globalTextStyle.copyWith(color: isCod ? black : white, fontSize: 5.w, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  SizedBox(height: 11.h,),
                ],
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: primary, 
                  onTap: (){
                    //Add current cart to Current Orders array
                    currentOrders.add({
                      'order': cart,
                      'date': DateTime.now(),
                      'amount': cartValue - 200 - 300
                    });
                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                      'currentOrders': currentOrders,
                    });
                    
                    //Set cartvalue to 0
                    cartValue = 0;
                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                      'cartValue': 0,
                    });

                    //Empty the cart
                    cart = [];
                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                      'cart': cart,
                    });

                    Navigator.pushNamed(context, orderSuccess);
                  }, 
                  text: isEnglish? "Pay ${(cartValue-300-200).toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true)}" : "${(cartValue-300-200).toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true)} भुगतान करें", fontColor: white, borderColor: primary,)
                ],
              ),
              SizedBox(height: 2.h,),
            ]
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        onTap: (index){
          NavbarTabs.navigateToTab(context, index);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: orangeLight,
        unselectedItemColor: white,
        selectedLabelStyle: globalTextStyle,
        unselectedLabelStyle: globalTextStyle,
        items: 
        [
            BottomNavigationBarItem(
              backgroundColor: primary,
              icon: Icon(
                Icons.home_filled,
              ),
              label: isEnglish ? "Home" : "घर",
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              icon: Icon(
                Icons.local_shipping_rounded,
              ),
              label: isEnglish ? "Feed" : "चारा",
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              icon: Icon(
                Icons.people_rounded,
              ),
              label: isEnglish ? "Community" : "समुदाय",
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              icon: Icon(
                Icons.shopping_cart_rounded,
              ),
              label: isEnglish ? "Cart" : "कार्ट",
            ),     
        ],
        backgroundColor: primary,
      ),
    );
  }
}