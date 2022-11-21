import 'dart:convert';
import 'dart:math';

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
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart'as http;

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({super.key});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {

  bool isCod = true;

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  var _razorpay = Razorpay();

  int? amount;
  final _random = Random();

  @override
  void initState() { 
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<String?> generateRzpOrderId() async {

    try {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('${razorpayId}:${razorpaySecret}'))}';

    Map<String, dynamic> orderData = {
      "amount": ((cartValue-300-200)*100).toInt(),
      "currency": "INR",
      'receipt': 'CG_${1000 + _random.nextInt(9999 - 1000)}'
    };

    var res = await http.post(
      Uri.https("api.razorpay.com", "v1/orders"),
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/json'
      },
      body: json.encode(orderData),
    );

    print(res.body);

    if ((json.decode(res.body)).containsKey('error')) {
      return null;
    } else {
      return (json.decode(res.body))['id'];
    } 
    } catch (e) {
      print(e);
      throw e; 
    }
    
  }

  Future openGateWay() async {
    generateRzpOrderId().then((value){
      var options = {
      'key': 'rzp_live_hUk8LTeESrQ6lL',
      'amount': (buyNowValue*100).toInt(), //in the smallest currency sub-unit.
      'currency': "INR",
      'name': 'Cattle GURU',
      'description': 'Online purchase of cattle food',
      'order_id': value, // Generate order_id using Orders API
      'timeout': 300, // in seconds
      'prefill': {
        'contact': phoneNumber
      }
    };

    try {
      _razorpay.open(options); 
    } catch (e) {
      print(e); 
    }
    });
    
  }

  Future<void> rzpOpen(var opt) async {
    return _razorpay.open(opt);
  }

  @override
  void dispose() { 
    _razorpay.clear();
    super.dispose(); // Removes all listeners
  }

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
                  onTap: () async {

                    if(isCod == false){
                    // var options = {
                    //   'key': '<YOUR_KEY_ID>',
                    //   'amount': ((cartValue-300-200)*100).toInt(), //in the smallest currency sub-unit.
                    //   'currency': "INR",
                    //   'name': 'Cattle GURU',
                    //   'description': 'Online purchase of cattle food',
                    //   'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                    //   'timeout': 300,
                    //   'prefill': {
                    //     'contact': phoneNumber,
                    //   } // in seconds
                    // };

                    // // _razorpay.open(options);
                    // await rzpOpen(options);

                    await openGateWay();
                  }
                
                    //Add current cart to Current Orders array
                    currentOrders.add({
                      'orderId': Random().nextInt(1000),
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