import 'package:cattle_guru/features/cart/ui/widgets/cart_tile.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/features/product/ui/screens/product_screen.dart';
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
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  TextEditingController couponController = TextEditingController();
  
  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void dispose() { 
    couponController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "My Cart" : "मेरी कार्ट", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: GestureDetector(
          onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
          behavior: HitTestBehavior.opaque,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('customers').snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
                itemBuilder: (context, index) {
                  if(snapshot.hasData){
                    if(snapshot.data!.docs[index].get('uid') == currUserId){
                      cart = snapshot.data!.docs[index].get('cart').toList();
                      cartValue = snapshot.data!.docs[index].get('cartValue').toDouble();
                      currentOrders = snapshot.data!.docs[index].get('currentOrders').toList();
                      // if(cart.isNotEmpty){
                      //   qty = snapshot.data!.docs[index].get('cart')[index]['qty'];
                      // }
                      return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: 
                      cart.isEmpty ? 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 22.5.h,),
                                SizedBox(
                                  width: 33.w, 
                                  height: 30.w,
                                  child: const Image(image: AssetImage("./assets/images/empty_cart.png"), fit: BoxFit.fill,),
                                ),
                                SizedBox(height: 2.h,),
                                Center(
                                    child: SizedBox(
                                      width: 75.w,
                                      child: Text(isEnglish ?
                                        "You have no items in your cart, please browse our products to add them here."
                                        :
                                        "आपके कार्ट में कोई आइटम नहीं है, कृपया उन्हें यहां जोड़ने के लिए हमारे उत्पादों को ब्राउज़ करें।"
                                        , style: globalTextStyle.copyWith(color: black, fontSize: 3.w,), textAlign: TextAlign.center,),),
                                ),
                              ],
                            ),
                            SizedBox(height: 27.5.h,),
                            Column(
                              children: [
                                CustomButton(width: 90.w, height: 15.w, color: primary, 
                                onTap: (){
                                  Navigator.pushNamed(context, home);
                                }, 
                                text: isEnglish ? "Browse Products" : "उत्पादों को ब्राउज़ करें", fontColor: white, borderColor: primary),
                                SizedBox(height: 2.h,),
                              ],
                            )
                          ],
                        )
                      : 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 2.h,),
                              SizedBox(
                                width: 100.w,
                                height: 40.h,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: (cart.length),
                                        itemBuilder: (context, index2){
                                          return CartTile(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: cart[index2]['product'], isCarted: true, id: cart[index2]['product']['prodId'], prodQty: cart[index2]['qty'])));
                                            }, 
                                            imgUrl: cart[index2]['product']['imgUrls'][0],
                                            // cartItems[index].product.imgUrls[0], 
                                            productName: cart[index2]['product']['name'], 
                                            productWeight: cart[index2]['product']['weight'].toDouble(), 
                                            productPrice: cart[index2]['product']['price'].toDouble(), 
                                            onSubtract: (){
                                              if(cart[index2]['qty'] > 1){
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cartValue' : FieldValue.increment(-(cart[index2]['product']['price'].toDouble()))
                                                });
                                                cart[index2]['qty']--;
                                                print(cart);
                                                print(cart.length);
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cart': cart,
                                                });
                                                setState(() {
                                                
                                                });
                                              } 
                                              print("On Subtract:");
                                              print(cart[index2]['qty']);
                                              print(snapshot.data!.docs[index].get('cart')[index2]['qty']);
                                            }, 
                                            onAdd: (){
                                              if(cart[index2]['qty'] < cart[index2]['product']['units']){
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cartValue' : FieldValue.increment(snapshot.data!.docs[index].get('cart')[index2]['product']['price'].toDouble())
                                                });
                                                cart[index2]['qty']++;
                                                print(cart);
                                                print(snapshot.data!.docs[index].get('cart'));
                                                print(snapshot.data!.docs[index].get('cart') == cart);
                                                print(cart.length);
                                                print(snapshot.data!.docs[index].get('cart').length);
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cart': cart,
                                                });
                                                setState(() {
                                                
                                                });
                                              } 
                                              print("On Add:");
                                              print(cart[index2]['qty']);
                                              print(snapshot.data!.docs[index].get('cart')[index2]['qty']);
                                            },
                                            qty: cart[index2]['qty'],
                                          );
                                        }
                                      ),    
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextField(width: 57.w, controller: couponController, hintText: isEnglish ? "Enter Coupon Code" : "कूपन कोड डालें", label: isEnglish ? "Coupon Code" : "कूपन कोड", keyboardType: TextInputType.text),
                                  SizedBox(width: 3.w,),
                                  CustomButton(width: 30.w, height: 15.w, color: primary, onTap: (){}, text: isEnglish ? "Apply" : "कोड लागू करें", fontColor: white, borderColor: primary),
                                ],
                              ),
                              SizedBox(height: 2.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(isEnglish ? "Sub Total" : "कीमत", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                  
                                  Text(cartValue.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true), style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                                ],
                              ),
                              SizedBox(height: 1.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(isEnglish ? "Wallet" : "वॉलेट मनी", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                  Text("- ${200.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true)}", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                ],
                              ),
                              SizedBox(height: 1.h,),Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(isEnglish? "Discount" : "छूट", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                  Text("- ${300.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true)}", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                ],
                              ),
                              SizedBox(height: 1.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(isEnglish ? "Delivery Charge" : "पहुंचाने का शुल्क", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                  Text(0.toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true), style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                                ],
                              ),
                              SizedBox(height: 1.h,),
                              Container(
                                width: 100.w,
                                height: 0.5,
                                color: grey,
                              ),
                              SizedBox(height: 1.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(isEnglish ? "Total" : "कुल", style: globalTextStyle.copyWith(color: primary, fontSize: 4.w, fontWeight: FontWeight.bold)),
                                  
                                  Text((cartValue-300-200).toCurrencyString(leadingSymbol: "₹", useSymbolPadding: true), style: globalTextStyle.copyWith(color: primary, fontSize: 4.w, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              SizedBox(height: 2.h,),
                              CustomButton(width: 90.w, height: 15.w, color: primary,
                              onTap: (){
                                Navigator.pushNamed(context, paymentMode);
                              }, 
                              text: isEnglish? "Checkout" : "चेक आउट", fontColor: white, borderColor: primary, fontSize: 4.w,),
                              SizedBox(height: 2.h,),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const SizedBox();
                }
              },);
            }
          ),
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: primaryLight,
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.rectangle,
        padding: EdgeInsets.all(0),
        snakeViewColor: Colors.green,
        selectedItemColor: white,
        unselectedItemColor: primary,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: 3,
        onTap: (index){
          NavbarTabs.navigateToTab(context, index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: isEnglish ? "Home" : "घर",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_shipping_rounded,
            ),
            label: isEnglish ? "Feed" : "चारा",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_rounded,
            ),
            label: isEnglish ? "Community" : "समुदाय",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_rounded,
            ),
            label: isEnglish ? "Cart" : "कार्ट",
          ),    
        ],
      ),
    );
  }
}