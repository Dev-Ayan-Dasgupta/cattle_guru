import 'package:cattle_guru/features/checkout/ui/screens/checkout_screen.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/filter_labels.dart';
import 'package:cattle_guru/features/product/ui/screens/product_screen.dart';
import 'package:cattle_guru/features/product/ui/widgets/product_list_tile.dart';
import 'package:cattle_guru/models/product_categories.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key, required this.category, required this.categoryAux, required this.labelsSelected});

  final String category;
  final String categoryAux;
  int labelsSelected;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  List productCategories = [
    ProductCategories(imageUrl: "./assets/images/product_categories/khal.png", name: isEnglish ? "Khal" : "खल", isSelected: false),
    ProductCategories(imageUrl: "./assets/images/product_categories/binola.png", name: isEnglish ? "Binola" : "बिनोला", isSelected: false),
    ProductCategories(imageUrl: "./assets/images/product_categories/feed.png", name: isEnglish ? "Feed" : "चारा", isSelected: false),
    ProductCategories(imageUrl: "./assets/images/product_categories/silage.png", name: isEnglish ? "Silage" : "सिलेज", isSelected: false),
  ];

  void setCategory(String cat){
    if(cat == "Khal"){
      productCategories[0].isSelected = true;
    }
    if(cat == "Binola"){
      productCategories[1].isSelected = true;
    }
    if(cat == "Feed"){
      productCategories[2].isSelected = true;
    }
    if(cat == "Silage"){
      productCategories[3].isSelected = true;
    }
  }

  List<Map<String, dynamic>> filteredProducts = [];

  populateFilteredProducts(){
    filteredProducts.clear();
    if(widget.labelsSelected == 0){
      for(int i = 0; i < products.length; i++){
        filteredProducts.add(products[i]);
      }
    } else {
      for(int i = 0; i < products.length; i++){
        if(productCategories[0].isSelected == true){
          if(products[i]['category'] == "Khal"){
            filteredProducts.add(Map.from(products[i]));
          }
        }
        if(productCategories[1].isSelected == true){
          if(products[i]['category'] == "Binola"){
            filteredProducts.add(Map.from(products[i]));
          }
        }
        if(productCategories[2].isSelected == true){
          if(products[i]['category'] == "Feed"){
            filteredProducts.add(Map.from(products[i]));
          }
        }
        if(productCategories[3].isSelected == true){
          if(products[i]['category'] == "Silage"){
            filteredProducts.add(Map.from(products[i]));
          }
        }
      }
    }
  }

  @override
  void initState() { 
    super.initState();
    setCategory(widget.categoryAux);
    // showFilteredProducts();
    populateFilteredProducts();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Product List" : "उत्पादों की सूची", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SizedBox(
              height: 80.h,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 2.h,),
                            SizedBox(
                              width: 100.w,
                              height: 8.w,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: productCategories.length,
                                      itemBuilder: (context, index){
                                        
                                        return FilterLabel(
                                          onTap: (){
                                            setState(() {
                                              if(productCategories[index].isSelected == true){
                                                widget.labelsSelected--;
                                              } else {
                                                widget.labelsSelected++;
                                              }
                                              productCategories[index].isSelected = !productCategories[index].isSelected;
                                              
                                              populateFilteredProducts();
                                            });
                                          }, 
                                          isSelected: productCategories[index].isSelected, text: productCategories[index].name);
                                        // Text(productCategories[index].name);
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            // InkWell(
                            //   onTap: (){
                            //     print(widget.labelsSelected);
                            //     print(productCategories[0].isSelected);
                            //     print(productCategories[1].isSelected);
                            //     print(productCategories[2].isSelected);
                            //     print(productCategories[3].isSelected);
                            //     print(products.length);
                            //     print(products);
                            //     print(selectedCategories);
                            //     print(filteredProducts.length);
                            //     print(filteredProducts);
                                
                            //   },
                            //   child: Text("Products")),
                            // SizedBox(height: 2.h,),
                            SizedBox(
                              width: 100.w,
                              height: 68.h,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: filteredProducts.length,
                                      itemBuilder: (context, index){
                                        
                                        bool productIsCarted = false;
                                        int prodQty = 0;

                                        for(int i = 0; i < cart.length; i++){
                                          if(filteredProducts[index]['prodId'] == cart[i]['product']['prodId']){
                                            productIsCarted = true;
                                            prodQty = cart[i]['qty'];
                                            break;
                                          }
                                        }

                                        return ProductListTile(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                              ProductScreen(
                                                product: filteredProducts[index], 
                                                isCarted: productIsCarted, 
                                                id: filteredProducts[index]['prodId'],
                                                prodQty: prodQty,
                                              )));
                                          },
                                          imgUrl: filteredProducts[index]['imgUrls'][0], 
                                          productDeliveryDays: filteredProducts[index]['deliveryDays'], 
                                          date: DateTime.now(), 
                                          productName: filteredProducts[index]['name'], 
                                          productWeight: filteredProducts[index]['weight'].toDouble(), 
                                          price: filteredProducts[index]['price'].toDouble(), 
                                          mrp: filteredProducts[index]['mrp'].toDouble(), 
                                          protein: filteredProducts[index]['protein'].toDouble(), 
                                          fibre: filteredProducts[index]['fibre'].toDouble(), 
                                          fat: filteredProducts[index]['fat'].toDouble(), 
                                          isCarted: productIsCarted, 
                                          onSubtract: (){
                                            if(currUserId != null){

                                              if(prodQty > 1){
                                                
                                                prodQty--;
                                              
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cartValue': FieldValue.increment(-(filteredProducts[index]['price'])),
                                                });

                                                for(int i = 0; i < cart.length; i++){
                                                  if(filteredProducts[index]['prodId'] == cart[i]['product']['prodId']){
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
                                                
                                                prodQty--;
                                              
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cartValue': FieldValue.increment(-(filteredProducts[index]['price'])),
                                                }); 

                                                for(int i = 0; i < cart.length; i++){
                                                  if(filteredProducts[index]['prodId'] == cart[i]['product']['prodId']){
                                                    cart.remove(cart[i]);
                                                    break;
                                                  }
                                                }

                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'cart': cart,
                                                });

                                                productIsCarted = false;

                                                setState(() {
                                                  
                                                });

                                              }
                                              
                                            }
                                          }, 
                                          onAdd: (){
                                            if(currUserId != null && prodQty < filteredProducts[index]['units']){
                                              prodQty++;

                                              FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                'cartValue': FieldValue.increment(filteredProducts[index]['price']),
                                              });
                                              
                                              for(int i = 0; i < cart.length; i++){
                                                if(filteredProducts[index]['prodId'] == cart[i]['product']['prodId']){
                                                  cart[i]['qty']++;
                                                  break;
                                                }
                                              }

                                              FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                'cart': cart,
                                              });
                                            }
                                            setState(() {
                                              
                                            });
                                          }, 
                                          qty: prodQty, 
                                          width: 23.5.w, 
                                          height: 20.w, 
                                          onAddToCart: () async {
                                            if(currUserId != null) {
                                              prodQty++;
                                              cart.add(
                                                {
                                                  'product': filteredProducts[index],
                                                  'qty': 1
                                                }
                                              );
                                              productIsCarted = true;
                                              await FirebaseFirestore.instance.collection('customers').doc(currUserId).update(
                                                {
                                                  'cart': cart,
                                                });
                                              await FirebaseFirestore.instance.collection('customers').doc(currUserId).
                                              update({
                                                'cartValue': FieldValue.increment(filteredProducts[index]['price']),
                                              });
                                            }
                                            setState(() {
                                              
                                            });
                                          },
                                          onBuyNow: (){
                                            buyNowValue = filteredProducts[index]['price'].toDouble();
                                            auxBuyNowValue = filteredProducts[index]['price'].toDouble();
                                            buyNowProduct = filteredProducts[index];
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: products[index])));
                                          },
                                        );
                                      }
                                    )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  )
                ],
              )
            ),
          ),
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: primaryLight,
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        padding: EdgeInsets.all(0),
        snakeViewColor: Colors.green,
        selectedItemColor: primary,
        unselectedItemColor: primary,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: 1,
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