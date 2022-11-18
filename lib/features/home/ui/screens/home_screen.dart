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
        title: Text(isEnglish ? "Home" : "होम स्क्रीन", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                    firestoreCurrentAddress = snapshot.data!.docs[index].get('currentAddress');
                    // if(cart.isNotEmpty){
                    //   qty = snapshot.data!.docs[index].get('cart')[index]['qty'];
                    // }
                    List productCategories = [
                      ProductCategories(imageUrl: "./assets/images/product_categories/khal.png", name: isEnglish ? "Khal" : "खल", isSelected: false),
                      ProductCategories(imageUrl: "./assets/images/product_categories/binola.png", name: isEnglish ? "Binola" : "बिनोला", isSelected: false),
                      ProductCategories(imageUrl: "./assets/images/product_categories/feed.png", name: isEnglish ? "Feed" : "चारा", isSelected: false),
                      ProductCategories(imageUrl: "./assets/images/product_categories/silage.png", name: isEnglish ? "Silage" : "सिलेज", isSelected: false),
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
                          SizedBox(height: 2.h,),
                          // InkWell(
                          //   onTap: (){
                          //     print(products.length);
                          //     print(products);
                          //   },
                          //   child: Text("Products")),
                          // SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Categories" : "श्रेणियाँ", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          // CustomTextLabel(width: 20.w, height: 6.w, text: isEnglish ? "Categories" : "श्रेणियाँ", color: primary, fontColor: white),
                          SizedBox(height: 1.h,),
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
                                        onTap: (){
                                          if(isEnglish ? productCategories[index].name == "Khal" : productCategories[index].name == "खल"){
                                            categoryAux = "Khal";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Khal", categoryAux: categoryAux, labelsSelected: 1,)));
                                          }
                                          if(isEnglish ? productCategories[index].name == "Binola" : productCategories[index].name == "बिनोला"){
                                            categoryAux = "Binola";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Binola", categoryAux: categoryAux, labelsSelected: 1)));
                                          }
                                          if(isEnglish ? productCategories[index].name == "Feed" : productCategories[index].name == "चारा"){
                                            categoryAux = "Feed";
                                            selectedCategories.add(categoryAux);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "Feed", categoryAux: categoryAux, labelsSelected: 1)));
                                          }
                                          if(isEnglish ? productCategories[index].name == "Silage" : productCategories[index].name == "सिलेज"){
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
                          SizedBox(height: 2.h,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(isEnglish ? "Products" : "प्रोडक्ट", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          // CustomTextLabel(width: 20.w, height: 6.w, text: isEnglish ? "Products" : "प्रोडक्ट", color: primary, fontColor: white),
                          SizedBox(height: 1.h,),
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
                                                // print(snapshot.data!.docs.length);
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
                                              onBuyNow: (){
                                                buyNowValue = products[index2]['price'].toDouble();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(product: products[index2])));
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
                            child: Text(isEnglish ? "Experts on Dairy Farming" : "डेयरी फार्मिंग के विशेषज्ञ", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                          ),
                          // CustomTextLabel(width: 40.w, height: 6.w, text: isEnglish ? "Experts on Dairy Farming" : "डेयरी फार्मिंग के विशेषज्ञ", color: primary, fontColor: white),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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

