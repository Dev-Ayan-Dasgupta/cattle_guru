import 'package:carousel_slider/carousel_slider.dart';
import 'package:cattle_guru/features/checkout/ui/screens/checkout_screen.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textlabel.dart';
import 'package:cattle_guru/features/home/ui/widgets/product_category_tile.dart';
import 'package:cattle_guru/features/home/ui/widgets/product_tile.dart';
import 'package:cattle_guru/features/home/ui/widgets/video_thumbnail.dart';
import 'package:cattle_guru/features/product/ui/screens/product_list.dart';
import 'package:cattle_guru/features/product/ui/screens/product_screen.dart';
import 'package:cattle_guru/features/youtube_videos/ui/screens/youtube_player.dart';
import 'package:cattle_guru/models/product_categories.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentCarouselIndex = 0;

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 2,
        ),
        width: currentIndex == index ? 15 : 10,
        height: 3,
        decoration: BoxDecoration(
          color: currentIndex == index ? primary : grey,
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Home" : "????????? ?????????????????????", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('customers').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index){
                if(snapshot.hasData){
                  if(snapshot.data!.docs[index].get('uid') == currUserId){
                    cart = snapshot.data!.docs[index].get('cart').toList();
                    cartValue = snapshot.data!.docs[index].get('cartValue').toDouble();
                    userName = snapshot.data!.docs[index].get('name');
                    phoneNumber = snapshot.data!.docs[index].get('phoneNumber');
                    profileImgUrl = snapshot.data!.docs[index].get('profileImgUrl');
                    isEnglish = snapshot.data!.docs[index].get('isEnglish');
                    likedShorts = snapshot.data!.docs[index].get('likedShorts');
                    dislikedShorts = snapshot.data!.docs[index].get('dislikedShorts');
                    firestoreCurrentAddress = snapshot.data!.docs[index].get('currentAddress');
                    // if(cart.isNotEmpty){
                    //   qty = snapshot.data!.docs[index].get('cart')[index]['qty'];
                    // }
                    List productCategories = [
                      ProductCategories(imageUrl: "./assets/images/product_categories/khal.png", name: isEnglish ? "Khal" : "??????", isSelected: false),
                      ProductCategories(imageUrl: "./assets/images/product_categories/binola.png", name: isEnglish ? "Binola" : "??????????????????", isSelected: false),
                      ProductCategories(imageUrl: "./assets/images/product_categories/feed.png", name: isEnglish ? "Feed" : "????????????", isSelected: false),
                      ProductCategories(imageUrl: "./assets/images/product_categories/silage.png", name: isEnglish ? "Silage" : "???????????????", isSelected: false),
                    ];
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            items: carouselImageListHome.map<Widget>((i){
                              return Builder(
                                builder: (context){
                                  return Container(
                                    width: 100.w,
                                    height: (360/202).w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(i), fit: BoxFit.fill),
                                    ),
                                  );
                                }
                              );
                            }).toList(), 
                            options: CarouselOptions(
                              height: 202,
                              aspectRatio: 360/202,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              initialPage: 0,
                              viewportFraction: 1,
                              onPageChanged: (index, timed) {
                                setState(() {
                                  _currentCarouselIndex = index;
                                });
                              }
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(
                              carouselImageListHome.length, _currentCarouselIndex),
                          ),
                          SizedBox(height: 1.h,),
                          // InkWell(
                          //   onTap: (){
                          //     print(productsKhal.length);
                          //     print(productsKhal);
                          //     print(khalProducts.length);
                          //     print(khalProducts);
                          //   },
                          //   child: Text("Products")),
                          // SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Categories" : "???????????????????????????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          // CustomTextLabel(width: 20.w, height: 6.w, text: isEnglish ? "Categories" : "???????????????????????????", color: primary, fontColor: white),
                          SizedBox(height: 1.h,),
                          Container(
                            width: 100.w,
                            height: 14.75.h,
                            color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: productCategories.length,
                                    itemBuilder: (context, index){
                                      return ProductCategoryTile(
                                        onTap: (){
                                          if(isEnglish ? productCategories[index].name == "Khal" : productCategories[index].name == "??????"){
                                            categoryAux = "Khal";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Khal", categoryAux: categoryAux, labelsSelected: 1,)));
                                          }
                                          if(isEnglish ? productCategories[index].name == "Binola" : productCategories[index].name == "??????????????????"){
                                            categoryAux = "Binola";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Binola", categoryAux: categoryAux, labelsSelected: 1)));
                                          }
                                          if(isEnglish ? productCategories[index].name == "Feed" : productCategories[index].name == "????????????"){
                                            categoryAux = "Feed";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Feed", categoryAux: categoryAux, labelsSelected: 1)));
                                          }
                                          if(isEnglish ? productCategories[index].name == "Silage" : productCategories[index].name == "???????????????"){
                                            categoryAux = "Silage";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Silage", categoryAux: categoryAux, labelsSelected: 1)));
                                          }
                                        }, 
                                        width: 10.w, 
                                        imageUrl: productCategories[index].imageUrl, 
                                        productCategoryName: productCategories[index].name,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 2.h,),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 5.w),
                          //   child: Text(isEnglish ? "Products" : "????????????????????????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          // ),
                          // // CustomTextLabel(width: 20.w, height: 6.w, text: isEnglish ? "Products" : "????????????????????????", color: primary, fontColor: white),
                          // SizedBox(height: 1.h,),
                          SizedBox(
                            width: 0.w,
                            height: 0.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('cattle-feed').snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        products.clear();
                                        products2 = snapshot.data!.docs;
                                        for(int i = 0; i < products2.length; i++){
                                          products.add(Map.from(products2[i].data()));
                                        }
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index2){
                                            
                                            // products.add(Map.from(snapshot.data!.docs[index2].data()));
                                            
                                            bool productIsCarted = false;
                                            int prodQty = 0;
                                            
                                            for(int i = 0; i < cart.length; i++){
                                              if(products[index2]['prodId'] == cart[i]['product']['prodId']){
                                                productIsCarted = true;
                                                prodQty = cart[i]['qty'];
                                                break;
                                              }
                                            }
                                            return SizedBox();
                                            // return ProductTile(
                                            //   onTap: (){
                                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                            //     ProductScreen(
                                            //       product: products[index2], 
                                            //       isCarted: productIsCarted, 
                                            //       id: products[index2]['prodId'],
                                            //       prodQty: prodQty,
                                            //     )));
                                            //   },
                                            //   width: 40.w, 
                                            //   height: 40.w, 
                                            //   imgUrl: products[index2]['imgUrls'][0],
                                            //   title: products[index2]['name'], 
                                            //   price: products[index2]['price'].toDouble(), 
                                            //   description: products[index2]['description'], 
                                            //   onAddToCart: () async {
                                            //     // print(snapshot.data!.docs.length);
                                            //     if(currUserId != null) {
                                            //       prodQty++;
                                            //       cart.add(
                                            //         {
                                            //           'product': products[index2],
                                            //           'qty': 1
                                            //         }
                                            //       );
                                            //       productIsCarted = true;
                                            //       await FirebaseFirestore.instance.collection('customers').doc(currUserId).update(
                                            //         {
                                            //           'cart': cart,
                                            //         });
                                            //       await FirebaseFirestore.instance.collection('customers').doc(currUserId).
                                            //       update({
                                            //         'cartValue': FieldValue.increment(products[index2]['price']),
                                            //       });
                                            //     }
                                            //     setState(() {
                                                  
                                            //     });
                                            //   },
                                            //   isCarted: productIsCarted,
                                            //   onAdd: (){
                                            //     if(currUserId != null && prodQty < products[index2]['units']){
                                            //       prodQty++;

                                            //       FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                            //         'cartValue': FieldValue.increment(products[index2]['price']),
                                            //       });
                                                  
                                            //       for(int i = 0; i < cart.length; i++){
                                            //         if(products[index2]['prodId'] == cart[i]['product']['prodId']){
                                            //           cart[i]['qty']++;
                                            //           break;
                                            //         }
                                            //       }

                                            //       FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                            //         'cart': cart,
                                            //       });
                                            //     }
                                            //   },
                                            //   onSubtract: (){
                                                
                                            //     if(currUserId != null){

                                            //       if(prodQty > 1){
                                                    
                                            //         prodQty--;
                                                  
                                            //         FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                            //           'cartValue': FieldValue.increment(-(products[index2]['price'])),
                                            //         });

                                            //         for(int i = 0; i < cart.length; i++){
                                            //           if(products[index2]['prodId'] == cart[i]['product']['prodId']){
                                            //             cart[i]['qty']--;
                                            //             break;
                                            //           }
                                            //         }

                                            //         FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                            //           'cart': cart,
                                            //         });

                                            //       } else {
                                                    
                                            //         prodQty--;
                                                  
                                            //         FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                            //           'cartValue': FieldValue.increment(-(products[index2]['price'])),
                                            //         }); 

                                            //         for(int i = 0; i < cart.length; i++){
                                            //           if(products[index2]['prodId'] == cart[i]['product']['prodId']){
                                            //             cart.remove(cart[i]);
                                            //             break;
                                            //           }
                                            //         }

                                            //         FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                            //           'cart': cart,
                                            //         });

                                            //         productIsCarted = false;

                                            //         setState(() {
                                                      
                                            //         });

                                            //       }
                                                  
                                            //     }

                                            //   },
                                            //   qty: prodQty,
                                            //   onBuyNow: (){
                                            //     buyNowValue = products[index2]['price'].toDouble();
                                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: products[index2])));
                                            //   },
                                            // );
                                          }
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Khal" : "??????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: 100.w,
                            height: 83.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('cattle-feed').snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        // productsKhal.clear();
                                        khalProducts.clear();
                                        productsKhal = snapshot.data!.docs;
                                        for(int i = 0; i < productsKhal.length; i++){
                                          if(productsKhal[i]['category'] == "Khal"){
                                            khalProducts.add(Map.from(productsKhal[i].data()));
                                          }
                                        }
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: khalProducts.length,
                                          itemBuilder: (context, index2){
                                            
                                            // products.add(Map.from(snapshot.data!.docs[index2].data()));
                                            
                                            bool productIsCarted = false;
                                            int prodQty = 0;
                                            
                                            for(int i = 0; i < cart.length; i++){
                                              if(khalProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                productIsCarted = true;
                                                prodQty = cart[i]['qty'];
                                                break;
                                              }
                                            }

                                            return ProductTile(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                                ProductScreen(
                                                  product: khalProducts[index2], 
                                                  isCarted: productIsCarted, 
                                                  id: khalProducts[index2]['prodId'],
                                                  prodQty: prodQty,
                                                )));
                                              },
                                              width: 40.w, 
                                              height: 40.w, 
                                              imgUrl: khalProducts[index2]['imgUrls'][0],
                                              title: khalProducts[index2]['name'], 
                                              price: khalProducts[index2]['price'].toDouble(), 
                                              description: khalProducts[index2]['description'], 
                                              onAddToCart: () async {
                                                // print(snapshot.data!.docs.length);
                                                if(currUserId != null) {
                                                  prodQty++;
                                                  cart.add(
                                                    {
                                                      'product': khalProducts[index2],
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
                                                    'cartValue': FieldValue.increment(khalProducts[index2]['price']),
                                                  });
                                                }
                                                setState(() {
                                                  
                                                });
                                              },
                                              isCarted: productIsCarted,
                                              onAdd: (){
                                                if(currUserId != null && prodQty < khalProducts[index2]['units']){
                                                  prodQty++;

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cartValue': FieldValue.increment(khalProducts[index2]['price']),
                                                  });
                                                  
                                                  for(int i = 0; i < cart.length; i++){
                                                    if(khalProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                      cart[i]['qty']++;
                                                      break;
                                                    }
                                                  }

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cart': cart,
                                                  });
                                                }
                                              },
                                              onSubtract: (){
                                                
                                                if(currUserId != null){

                                                  if(prodQty > 1){
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(khalProducts[index2]['price'])),
                                                    });

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(khalProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                        cart[i]['qty']--;
                                                        break;
                                                      }
                                                    }

                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cart': cart,
                                                    });

                                                  } else {
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(khalProducts[index2]['price'])),
                                                    }); 

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(khalProducts[index2]['prodId'] == cart[i]['product']['prodId']){
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
                                              qty: prodQty,
                                              onBuyNow: (){
                                                buyNowValue = khalProducts[index2]['price'].toDouble();
                                                auxBuyNowValue = khalProducts[index2]['price'].toDouble();
                                                buyNowProduct = khalProducts[index2];
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: khalProducts[index2])));
                                              },
                                            );
                                          }
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Binola" : "??????????????????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: 100.w,
                            height: 83.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('cattle-feed').snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        // productsKhal.clear();
                                        binolaProducts.clear();
                                        productsBinola = snapshot.data!.docs;
                                        for(int i = 0; i < productsBinola.length; i++){
                                          if(productsBinola[i]['category'] == "Binola"){
                                            binolaProducts.add(Map.from(productsBinola[i].data()));
                                          }
                                        }
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: binolaProducts.length,
                                          itemBuilder: (context, index2){
                                            
                                            // products.add(Map.from(snapshot.data!.docs[index2].data()));
                                            
                                            bool productIsCarted = false;
                                            int prodQty = 0;
                                            
                                            for(int i = 0; i < cart.length; i++){
                                              if(binolaProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                productIsCarted = true;
                                                prodQty = cart[i]['qty'];
                                                break;
                                              }
                                            }

                                            return ProductTile(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                                ProductScreen(
                                                  product: binolaProducts[index2], 
                                                  isCarted: productIsCarted, 
                                                  id: binolaProducts[index2]['prodId'],
                                                  prodQty: prodQty,
                                                )));
                                              },
                                              width: 40.w, 
                                              height: 40.w, 
                                              imgUrl: binolaProducts[index2]['imgUrls'][0],
                                              title: binolaProducts[index2]['name'], 
                                              price: binolaProducts[index2]['price'].toDouble(), 
                                              description: binolaProducts[index2]['description'], 
                                              onAddToCart: () async {
                                                // print(snapshot.data!.docs.length);
                                                if(currUserId != null) {
                                                  prodQty++;
                                                  cart.add(
                                                    {
                                                      'product': binolaProducts[index2],
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
                                                    'cartValue': FieldValue.increment(binolaProducts[index2]['price']),
                                                  });
                                                }
                                                setState(() {
                                                  
                                                });
                                              },
                                              isCarted: productIsCarted,
                                              onAdd: (){
                                                if(currUserId != null && prodQty < binolaProducts[index2]['units']){
                                                  prodQty++;

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cartValue': FieldValue.increment(binolaProducts[index2]['price']),
                                                  });
                                                  
                                                  for(int i = 0; i < cart.length; i++){
                                                    if(binolaProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                      cart[i]['qty']++;
                                                      break;
                                                    }
                                                  }

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cart': cart,
                                                  });
                                                }
                                              },
                                              onSubtract: (){
                                                
                                                if(currUserId != null){

                                                  if(prodQty > 1){
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(binolaProducts[index2]['price'])),
                                                    });

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(binolaProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                        cart[i]['qty']--;
                                                        break;
                                                      }
                                                    }

                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cart': cart,
                                                    });

                                                  } else {
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(binolaProducts[index2]['price'])),
                                                    }); 

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(binolaProducts[index2]['prodId'] == cart[i]['product']['prodId']){
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
                                              qty: prodQty,
                                              onBuyNow: (){
                                                buyNowValue = binolaProducts[index2]['price'].toDouble();
                                                auxBuyNowValue = binolaProducts[index2]['price'].toDouble();
                                                buyNowProduct = binolaProducts[index2];
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: binolaProducts[index2])));
                                              },
                                            );
                                          }
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Feed" : "????????????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: 100.w,
                            height: 83.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('cattle-feed').snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        // productsKhal.clear();
                                        feedProducts.clear();
                                        productsFeed = snapshot.data!.docs;
                                        for(int i = 0; i < productsFeed.length; i++){
                                          if(productsFeed[i]['category'] == "Feed"){
                                            feedProducts.add(Map.from(productsFeed[i].data()));
                                          }
                                        }
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: feedProducts.length,
                                          itemBuilder: (context, index2){
                                            
                                            // products.add(Map.from(snapshot.data!.docs[index2].data()));
                                            
                                            bool productIsCarted = false;
                                            int prodQty = 0;
                                            
                                            for(int i = 0; i < cart.length; i++){
                                              if(feedProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                productIsCarted = true;
                                                prodQty = cart[i]['qty'];
                                                break;
                                              }
                                            }

                                            return ProductTile(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                                ProductScreen(
                                                  product: feedProducts[index2], 
                                                  isCarted: productIsCarted, 
                                                  id: feedProducts[index2]['prodId'],
                                                  prodQty: prodQty,
                                                )));
                                              },
                                              width: 40.w, 
                                              height: 40.w, 
                                              imgUrl: feedProducts[index2]['imgUrls'][0],
                                              title: feedProducts[index2]['name'], 
                                              price: feedProducts[index2]['price'].toDouble(), 
                                              description: feedProducts[index2]['description'], 
                                              onAddToCart: () async {
                                                // print(snapshot.data!.docs.length);
                                                if(currUserId != null) {
                                                  prodQty++;
                                                  cart.add(
                                                    {
                                                      'product': feedProducts[index2],
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
                                                    'cartValue': FieldValue.increment(feedProducts[index2]['price']),
                                                  });
                                                }
                                                setState(() {
                                                  
                                                });
                                              },
                                              isCarted: productIsCarted,
                                              onAdd: (){
                                                if(currUserId != null && prodQty < feedProducts[index2]['units']){
                                                  prodQty++;

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cartValue': FieldValue.increment(feedProducts[index2]['price']),
                                                  });
                                                  
                                                  for(int i = 0; i < cart.length; i++){
                                                    if(feedProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                      cart[i]['qty']++;
                                                      break;
                                                    }
                                                  }

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cart': cart,
                                                  });
                                                }
                                              },
                                              onSubtract: (){
                                                
                                                if(currUserId != null){

                                                  if(prodQty > 1){
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(feedProducts[index2]['price'])),
                                                    });

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(feedProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                        cart[i]['qty']--;
                                                        break;
                                                      }
                                                    }

                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cart': cart,
                                                    });

                                                  } else {
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(feedProducts[index2]['price'])),
                                                    }); 

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(feedProducts[index2]['prodId'] == cart[i]['product']['prodId']){
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
                                              qty: prodQty,
                                              onBuyNow: (){
                                                buyNowValue = feedProducts[index2]['price'].toDouble();
                                                auxBuyNowValue = feedProducts[index2]['price'].toDouble();
                                                buyNowProduct = feedProducts[index2];
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: feedProducts[index2])));
                                              },
                                            );
                                          }
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Silage" : "???????????????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: 100.w,
                            height: 83.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('cattle-feed').snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        // productsKhal.clear();
                                        silageProducts.clear();
                                        productsSilage = snapshot.data!.docs;
                                        for(int i = 0; i < productsSilage.length; i++){
                                          if(productsSilage[i]['category'] == "Silage"){
                                            silageProducts.add(Map.from(productsSilage[i].data()));
                                          }
                                        }
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: silageProducts.length,
                                          itemBuilder: (context, index2){
                                            
                                            // products.add(Map.from(snapshot.data!.docs[index2].data()));
                                            
                                            bool productIsCarted = false;
                                            int prodQty = 0;
                                            
                                            for(int i = 0; i < cart.length; i++){
                                              if(silageProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                productIsCarted = true;
                                                prodQty = cart[i]['qty'];
                                                break;
                                              }
                                            }

                                            return ProductTile(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                                ProductScreen(
                                                  product: silageProducts[index2], 
                                                  isCarted: productIsCarted, 
                                                  id: silageProducts[index2]['prodId'],
                                                  prodQty: prodQty,
                                                )));
                                              },
                                              width: 40.w, 
                                              height: 40.w, 
                                              imgUrl: silageProducts[index2]['imgUrls'][0],
                                              title: silageProducts[index2]['name'], 
                                              price: silageProducts[index2]['price'].toDouble(), 
                                              description: silageProducts[index2]['description'], 
                                              onAddToCart: () async {
                                                // print(snapshot.data!.docs.length);
                                                if(currUserId != null) {
                                                  prodQty++;
                                                  cart.add(
                                                    {
                                                      'product': silageProducts[index2],
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
                                                    'cartValue': FieldValue.increment(silageProducts[index2]['price']),
                                                  });
                                                }
                                                setState(() {
                                                  
                                                });
                                              },
                                              isCarted: productIsCarted,
                                              onAdd: (){
                                                if(currUserId != null && prodQty < silageProducts[index2]['units']){
                                                  prodQty++;

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cartValue': FieldValue.increment(silageProducts[index2]['price']),
                                                  });
                                                  
                                                  for(int i = 0; i < cart.length; i++){
                                                    if(silageProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                      cart[i]['qty']++;
                                                      break;
                                                    }
                                                  }

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cart': cart,
                                                  });
                                                }
                                              },
                                              onSubtract: (){
                                                
                                                if(currUserId != null){

                                                  if(prodQty > 1){
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(silageProducts[index2]['price'])),
                                                    });

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(silageProducts[index2]['prodId'] == cart[i]['product']['prodId']){
                                                        cart[i]['qty']--;
                                                        break;
                                                      }
                                                    }

                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cart': cart,
                                                    });

                                                  } else {
                                                    
                                                    prodQty--;
                                                  
                                                    FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                      'cartValue': FieldValue.increment(-(silageProducts[index2]['price'])),
                                                    }); 

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(silageProducts[index2]['prodId'] == cart[i]['product']['prodId']){
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
                                              qty: prodQty,
                                              onBuyNow: (){
                                                buyNowValue = silageProducts[index2]['price'].toDouble();
                                                auxBuyNowValue = silageProducts[index2]['price'].toDouble();
                                                buyNowProduct = silageProducts[index2];
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: silageProducts[index2])));
                                              },
                                            );
                                          }
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Experts on Dairy Farming" : "??????????????? ???????????????????????? ?????? ????????????????????????", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          // CustomTextLabel(width: 40.w, height: 6.w, text: isEnglish ? "Experts on Dairy Farming" : "??????????????? ???????????????????????? ?????? ????????????????????????", color: primary, fontColor: white),
                          SizedBox(height: 1.h,),
                          SizedBox(
                            width: 100.w,
                            height: 35.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: videoThumbnails.length,
                                    itemBuilder: (context, index){
                                      return SizedBox(
                                        width: 40.w,
                                        child: VideoThumbnailTile(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => YouTubePlayerScreen(url: videoThumbnails[index].videoUrl, title: videoThumbnails[index].name,)));
                                          }, 
                                          width: 40.w, 
                                          height: 24.w,
                                          imgUrl: videoThumbnails[index].thumbUrl, 
                                          videoName: videoThumbnails[index].name,
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
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
              },
            );
            
          }
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: primaryLight,
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.circle,
        // shape: ShapeBorder.lerp(a, b, t),
        padding: EdgeInsets.all(0),
        snakeViewColor: Colors.green,
        selectedItemColor: white,
        unselectedItemColor: primary,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: 0,
        onTap: (index){
          NavbarTabs.navigateToTab(context, index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: isEnglish ? "Home" : "??????",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_shipping_rounded,
            ),
            label: isEnglish ? "Feed" : "????????????",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_rounded,
            ),
            label: isEnglish ? "Community" : "??????????????????",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_rounded,
            ),
            label: isEnglish ? "Cart" : "???????????????",
          ),    
        ],
      ),
      
      // BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: 0,
      //   onTap: (index){
      //     NavbarTabs.navigateToTab(context, index);
      //   },
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   selectedItemColor: orangeLight,
      //   unselectedItemColor: white,
      //   selectedLabelStyle: globalTextStyle,
      //   unselectedLabelStyle: globalTextStyle,
        
      //   items: 
      //     [
      //       BottomNavigationBarItem(
      //         backgroundColor: primary,
      //         icon: Icon(
      //           Icons.home_filled,
      //         ),
      //         label: isEnglish ? "Home" : "??????",
      //       ),
      //       BottomNavigationBarItem(
      //         backgroundColor: primary,
      //         icon: Icon(
      //           Icons.local_shipping_rounded,
      //         ),
      //         label: isEnglish ? "Feed" : "????????????",
      //       ),
      //       BottomNavigationBarItem(
      //         backgroundColor: primary,
      //         icon: Icon(
      //           Icons.people_rounded,
      //         ),
      //         label: isEnglish ? "Community" : "??????????????????",
      //       ),
      //       BottomNavigationBarItem(
      //         backgroundColor: primary,
      //         icon: Icon(
      //           Icons.shopping_cart_rounded,
      //         ),
      //         label: isEnglish ? "Cart" : "???????????????",
      //       ),     
      //   ]
      //   ,
      //   backgroundColor: primary,
      // ),
    );
  }
}

