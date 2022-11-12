import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/models/product_details.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
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
  final Map<String, dynamic> product;
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
        title: Text("Product Details", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                              Text("${((1-(price/mrp))*100).toInt()}% off", style: globalTextStyle.copyWith(color: grey, fontSize: 2.5.w,),),
                            ],
                          ),
                          SizedBox(height: 0.5.h,),
                          Text("You saved ₹ ${mrp - price}", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w,),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Weight: ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                              SizedBox(width: 1.w,),
                              Text("$weight kg", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                            ]
                          ),
                          SizedBox(height: 1.h,),
                          Text("₹ ${(price~/weight)} per kg", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w,),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Text("Description", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                  // CustomTextLabel(width: 20.w, height: 7.w, text: "Description", color: primary, fontColor: white),
                  SizedBox(height: 1.h,),
                  Text(widget.product['description'], style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                  SizedBox(height: 2.h,),
                  Text("Nutrient Information", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
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
                            Text("Protein", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
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
                            Text("Fibre", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
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
                            Text("Fat", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
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
                        Text("${units.toInt()} units in stock", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),) :
                        Text("Out of stock", style: globalTextStyle.copyWith(color: red, fontSize: 3.w, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
              Column(
                children: [
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
                        }
                      });
                    }
                  }, 
                  text: (widget.isCarted == true) ? "Remove from Cart" : "Add to Cart", fontColor: (widget.isCarted == true) ? red : white, borderColor: (widget.isCarted == true) ? red : primary),
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