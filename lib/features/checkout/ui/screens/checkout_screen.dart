import 'package:cattle_guru/features/address/ui/widgets/address_card.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/product/ui/screens/product_screen.dart';
import 'package:cattle_guru/features/product/ui/widgets/product_list_tile.dart';
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

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  bool isCod = true;

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Checkout" : "चेक आउट", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ProductListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                      ProductScreen(
                        product: widget.product, 
                        isCarted: false, 
                        id: widget.product['prodId'],
                        prodQty: 1,
                      )));
                  }, 
                  imgUrl: widget.product['imgUrls'][0], 
                  productDeliveryDays: widget.product['deliveryDays'], 
                  date: DateTime.now(), 
                  productName: widget.product['name'], 
                  productWeight: widget.product['weight'].toDouble(), 
                  price: widget.product['price'].toDouble(), 
                  mrp: widget.product['mrp'].toDouble(), 
                  protein: widget.product['protein'].toDouble(), 
                  fibre: widget.product['fibre'].toDouble(), 
                  fat: widget.product['fat'].toDouble(), 
                  isCarted: false, 
                  onSubtract: (){}, 
                  onAdd: (){}, 
                  qty: qty, 
                  width: 0, 
                  height: 0, 
                  onAddToCart: (){},
                  onBuyNow: (){},
                ),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("Deliver to", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 1.h,),
              AddressCard(
                onTap: (){}, 
                isDefault: false, 
                name: firestoreCurrentAddress['name'], 
                address: "${firestoreCurrentAddress['houseNum']}, ${firestoreCurrentAddress['village']}, ${firestoreCurrentAddress['district']}, ${firestoreCurrentAddress['state']}, ${firestoreCurrentAddress['pinCode']}", 
                onEditTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address: addressTiles[1], addressIndex: 1, isDefault: false,)));
                  Navigator.pushNamed(context, myAddresses);
                }, 
                onDefaultTap: (){
                  
                }, 
                onRemoveTap: (){},
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          isCod= true;
                        });
                      },
                      child: Container(
                        width: 44.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: primary),
                          borderRadius: BorderRadius.all(Radius.circular(2.w)),
                          color: isCod ? primary : primaryLight,
                        ),
                        child: Center(
                          child: Text(isEnglish ? "Cash on Delivery (COD)" : "डिलवरी पर नकदी", style: globalTextStyle.copyWith(color: isCod ? white : black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isCod = false;
                        });
                      },
                      child: Container(
                        width: 44.w,
                        height: 15.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: primary),
                          borderRadius: BorderRadius.all(Radius.circular(2.w)),
                          color: isCod ? primaryLight : primary,
                        ),
                        child: Center(
                          child: Text(isEnglish ? "Online Payment" : "ऑनलाइन भुगतान", style: globalTextStyle.copyWith(color: isCod ? black : white, fontSize: 3.w, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 1.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CustomButton(width: 90.w, height: 15.w, color: primary, 
                onTap: (){
                  //Add current product to Current Orders array
                      currentOrders.add({
                        'order': [{
                          'product': widget.product,
                          'qty': 1,
                        }],
                        'date': DateTime.now(),
                        'amount': buyNowValue
                      });
                      FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                        'currentOrders': currentOrders,
                      });
                      
                      //Set buyNowValue to 0
                      // cartValue = 0;
                      buyNowValue = 0;
                      // FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                      //   'cartValue': 0,
                      // });

                      //Empty the cart
                      // cart = [];
                      // FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                      //   'cart': cart,
                      // });

                      Navigator.pushNamed(context, orderSuccess);
                }, 
                text: isEnglish ? "Pay ${buyNowValue.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true)}" : "${buyNowValue.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true)} भुगतान करें ", fontColor: white, borderColor: primary),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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
        ]
        ,
        backgroundColor: primary,
      ),
    );
  }
}