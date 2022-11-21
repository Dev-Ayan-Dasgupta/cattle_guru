import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cattle_guru/features/checkout/ui/screens/checkout_screen.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/models/product_details.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key, required this.product, required this.isCarted, required this.id, required this.prodQty});

  // final ProductDetail product; 
  Map<String, dynamic> product;
  bool isCarted;
  final String id;
  int prodQty;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {

    widget.product['isCarted'] = true;

    // double price = widget.product.get('price').toDouble();
    double price = widget.product['price'].toDouble();
    // double mrp = widget.product.get('mrp').toDouble();
    double mrp = widget.product['mrp'].toDouble();
    // double weight = widget.product.get('weight').toDouble();
    double weight = widget.product['weight'].toDouble();
    // double protein = widget.product.get('protein').toDouble();
    double protein = widget.product['protein'].toDouble();
    // double fibre = widget.product.get('fibre').toDouble();
    double fibre = widget.product['fibre'].toDouble();
    // double fat = widget.product.get('fat').toDouble();
    double fat = widget.product['fat'].toDouble();
    // double units = widget.product.get('units').toDouble();
    double units = widget.product['units'].toDouble();
    // bool isCarted = widget.product.get('isCarted');
    String prodId = widget.product['prodId'];

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish? "Product Details" : "उत्पाद विवरण", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                  SizedBox(height: 2.5.h),
                  Center(child: SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: Image(image: AssetImage(widget.product['imgUrls'][0]), fit: BoxFit.fill,))),
                  SizedBox(height: 2.h),
                  Text(widget.product['name'], style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("₹ $price", style: globalTextStyle.copyWith(color: primary, fontSize: 5.w, fontWeight: FontWeight.bold),),
                              SizedBox(width: 2.w,),
                              Text(isEnglish ? "${((1-(price/mrp))*100).toInt()}% off" : "${((1-(price/mrp))*100).toInt()}% की छूट", style: globalTextStyle.copyWith(color: grey, fontSize: 2.5.w,),),
                            ],
                          ),
                          SizedBox(height: 0.5.h,),
                          Text(isEnglish ? "You saved ₹ ${mrp - price}" : "आपने बचा लिया ₹ ${mrp - price}", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w,),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(isEnglish ? "Weight: " : "वज़न: ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                              SizedBox(width: 1.w,),
                              Text("$weight kg", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                            ]
                          ),
                          SizedBox(height: 1.h,),
                          Text(isEnglish ? "₹ ${(price~/weight)} per kg" : "₹ ${(price~/weight)} प्रति kg", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w,),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Text(isEnglish ? "Description" : "विवरण", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                  // CustomTextLabel(width: 20.w, height: 7.w, text: "Description", color: primary, fontColor: white),
                  SizedBox(height: 1.h,),
                  Text(widget.product['description'], style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                  SizedBox(height: 2.h,),
                  Text(isEnglish ? "Nutrient Information" : "पोषक तत्व की जानकारी", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 8.w,
                        lineWidth: 1.w,
                        percent: protein/100,
                        center: Column(
                          children: [
                            SizedBox(height: 4.5.w,),
                            Text(isEnglish ? "Protein" : "प्रोटीन", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${protein.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                      SizedBox(width: 5.w),
                      CircularPercentIndicator(
                        radius: 8.w,
                        lineWidth: 1.w,
                        percent: fibre/100,
                        center: Column(
                          children: [
                            SizedBox(height: 4.5.w,),
                            Text(isEnglish ? "Fibre" : "रेशा", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${fibre.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                      SizedBox(width: 5.w),
                      CircularPercentIndicator(
                        radius: 8.w,
                        lineWidth: 1.w,
                        percent: fat/100,
                        center: Column(
                          children: [
                            SizedBox(height: 4.5.w,),
                            Text(isEnglish ? "Fat" : "वसा", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${fat.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      units.toInt() > 0 ?
                        Text(isEnglish ? "${units.toInt()} units in stock" : "स्टॉक में ${units.toInt()} इकाइयां", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),) :
                        Text(isEnglish ? "Out of stock" : "स्टॉक ख़त्म", style: globalTextStyle.copyWith(color: red, fontSize: 3.w, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  widget.isCarted ? 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          
                          if(widget.prodQty > 1){

                            widget.prodQty --;

                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                              'cartValue': FieldValue.increment(-(widget.product['price'])),
                            });

                            for(int i = 0; i < cart.length; i++){
                              if(widget.product['prodId'] == cart[i]['product']['prodId']){
                                cart[i]['qty']--;
                                break;
                              }
                            }

                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                              'cart': cart,
                            });

                            setState(() {
                              
                            });

                          } else {

                            widget.prodQty--;
                                                  
                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                              'cartValue': FieldValue.increment(-(widget.product['price'])),
                            }); 

                            for(int i = 0; i < cart.length; i++){
                              if(widget.product['prodId'] == cart[i]['product']['prodId']){
                                cart.remove(cart[i]);
                                break;
                              }
                            }

                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                              'cart': cart,
                            });

                            widget.isCarted = false;

                            setState(() {
                              
                            });
                          }
                        },
                        child: Icon(Icons.remove_circle, color: grey, size: 10.w,),
                      ),
                      SizedBox(width: 3.w,),
                      AnimatedFlipCounter(
                        value: widget.prodQty,
                        textStyle: globalTextStyle.copyWith(color: black, fontSize: 6.w, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 3.w,),
                      InkWell(
                        onTap: (){
                          if(widget.prodQty < widget.product['units']){

                            widget.prodQty++;

                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                              'cartValue': FieldValue.increment(widget.product['price']),
                            });

                            for(int i = 0; i < cart.length; i++){
                              if(widget.product['prodId'] == cart[i]['product']['prodId']){
                                cart[i]['qty']++;
                                break;
                              }
                            }

                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                              'cart': cart,
                            });

                            setState(() {
                              
                            });
                          }
                        },
                        child: Icon(Icons.add_circle, color: primary, size: 10.w,),
                      ),
                    ],
                  )
                  :
                  CustomButton(width: 90.w, height: 15.w, color: (widget.isCarted == true) ? lightRed : primary, 
                  onTap: () {
                    if((widget.isCarted == true)){
                      setState(() {
                        if(currUserId != null){
                          // FirebaseFirestore.instance.collection('cattle-feed').doc(widget.id).update({'isCarted': false});
                          for(int i = 0; i < cart.length; i++){
                            if(prodId == cart[i]['product']['prodId']){
                              cart.remove(cart[i]);
                            }
                          }
                          FirebaseFirestore.instance.collection('customers').doc(currUserId).
                            update({'cart': cart,
                          });
                          // FirebaseFirestore.instance.collection('cattle-feed').doc(widget.id).update({'isCarted': false});
                          
                          FirebaseFirestore.instance.collection('customers').doc(currUserId).
                            update({
                              'cartValue': FieldValue.increment(-(widget.product['price'].toDouble()*widget.prodQty))
                            });
                          widget.isCarted = false;
                        }
                      });
                    } else {
                      setState(() {
                        if(currUserId != null){
                          // FirebaseFirestore.instance.collection('cattle-feed').doc(widget.id).update({'isCarted': true});
                          cart.add({
                            'product': widget.product,
                            'qty': 1,
                          });
                          FirebaseFirestore.instance.collection('customers').doc(currUserId).
                            update({'cart': cart,
                          });
                          // FirebaseFirestore.instance.collection('cattle-feed').doc(widget.id).update({'isCarted': true});
                          FirebaseFirestore.instance.collection('customers').doc(currUserId).
                            update({
                              'cartValue': FieldValue.increment(widget.product['price'].toDouble())
                            });
                          widget.isCarted = true;
                          widget.prodQty++;
                        }
                      });
                    }
                  }, 
                  text: (widget.isCarted == true) ? isEnglish ? "Remove from Cart" : "कार्ट से हटायें" : isEnglish ? "Add to Cart" : "कार्ट में डालें", fontColor: (widget.isCarted == true) ? red : white, borderColor: (widget.isCarted == true) ? red : primary),
                  SizedBox(height: 1.h,),
                  CustomButton(width: 90.w, height: 15.w, color: primary, 
                  onTap: (){
                    buyNowValue = widget.product['price'].toDouble();
                    auxBuyNowValue = widget.product['price'].toDouble();
                    buyNowProduct = widget.product;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: widget.product)));
                  }, 
                  text: isEnglish ? "Buy Now" : "अभी खरीदें", fontColor: white, borderColor: primary, fontSize: 4.w,),
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
          NavbarTabs.navigateToTab(context, index);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: orangeLight,
        unselectedItemColor: white,
        selectedLabelStyle: globalTextStyle,
        unselectedLabelStyle: globalTextStyle,
        items: [
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