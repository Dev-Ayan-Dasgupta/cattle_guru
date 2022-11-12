import 'package:carousel_slider/carousel_slider.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textlabel.dart';
import 'package:cattle_guru/features/home/ui/widgets/product_category_tile.dart';
import 'package:cattle_guru/features/home/ui/widgets/product_tile.dart';
import 'package:cattle_guru/features/home/ui/widgets/video_thumbnail.dart';
import 'package:cattle_guru/features/product/ui/screens/product_screen.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentCarouselIndex = 0;

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, dynamic>> products = [];

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
        title: Text("Home", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                    // if(cart.isNotEmpty){
                    //   qty = snapshot.data!.docs[index].get('cart')[index]['qty'];
                    // }
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
                          //   onTap: (){Navigator.pushNamed(context, referral);},
                          //   child: const Text("Referral text",)),
                          SizedBox(height: 1.h,),
                          CustomTextLabel(width: 20.w, height: 6.w, text: "Categories", color: primary, fontColor: white),
                          SizedBox(height: 2.h,),
                          Container(
                            width: 100.w,
                            height: 30.w,
                            color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: productCategories.length,
                                    itemBuilder: (context, index){
                                      return ProductCategoryTile(
                                        onTap: (){}, 
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
                          SizedBox(height: 2.h,),
                          CustomTextLabel(width: 40.w, height: 6.w, text: "Experts on Dairy Farming", color: primary, fontColor: white),
                          SizedBox(height: 2.h,),
                          SizedBox(
                            width: 100.w,
                            height: 30.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: videoThumbnails.length,
                                    itemBuilder: (context, index){
                                      return VideoThumbnailTile(
                                        onTap: (){}, 
                                        width: 40.w, 
                                        height: 24.w,
                                        imgUrl: videoThumbnails[index].thumbUrl, 
                                        videoName: videoThumbnails[index].name,
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          // InkWell(
                          //   onTap: (){
                          //     print(products.length);
                          //     print(products);
                          //     print(cart.length);
                          //     print(cart);
                          //   },
                          //   child: Text("Test Products and Cart"),
                          // ),
                          SizedBox(height: 1.h,),
                          CustomTextLabel(width: 20.w, height: 6.w, text: "Products", color: primary, fontColor: white),
                          SizedBox(height: 2.h,),
                          SizedBox(
                            width: 100.w,
                            height: 71.5.w,
                            // color: primaryLight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('cattle-feed').snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index2){
                                            
                                            products.add(Map.from(snapshot.data!.docs[index2].data()));
                                            bool productIsCarted = false;

                                            int prodQty = 0;
                                            
                                            for(int i = 0; i < cart.length; i++){
                                              if(products[index2]['prodId'] == cart[i]['product']['prodId']){
                                                productIsCarted = true;
                                                prodQty = cart[i]['qty'];
                                                break;
                                              }
                                            }
                                            
                                            return ProductTile(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                                ProductScreen(
                                                  product: products[index2], 
                                                  isCarted: productIsCarted, 
                                                  id: products[index2]['prodId'],
                                                  prodQty: prodQty,
                                                )));
                                              },
                                              width: 40.w, 
                                              height: 40.w, 
                                              imgUrl: products[index2]['imgUrls'][0],
                                              title: products[index2]['name'], 
                                              price: products[index2]['price'].toDouble(), 
                                              description: products[index2]['description'], 
                                              onAddToCart: () async {
                                                if(currUserId != null) {
                                                  prodQty++;
                                                  cart.add(
                                                    {
                                                      'product': products[index2],
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
                                                    'cartValue': FieldValue.increment(products[index2]['price']),
                                                  });
                                                }
                                                setState(() {
                                                  
                                                });
                                              },
                                              isCarted: productIsCarted,
                                              onAdd: (){
                                                if(currUserId != null && prodQty < products[index2]['units']){
                                                  prodQty++;

                                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                    'cartValue': FieldValue.increment(products[index2]['price']),
                                                  });
                                                  
                                                  for(int i = 0; i < cart.length; i++){
                                                    if(products[index2]['prodId'] == cart[i]['product']['prodId']){
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
                                                      'cartValue': FieldValue.increment(-(products[index2]['price'])),
                                                    });

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(products[index2]['prodId'] == cart[i]['product']['prodId']){
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
                                                      'cartValue': FieldValue.increment(-(products[index2]['price'])),
                                                    }); 

                                                    for(int i = 0; i < cart.length; i++){
                                                      if(products[index2]['prodId'] == cart[i]['product']['prodId']){
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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

