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
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentCarouselIndex = 0;

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
        child: SingleChildScrollView(
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
                            imgUrl: videoThumbnails[index].imgUrl, 
                            videoName: videoThumbnails[index].name,
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              CustomTextLabel(width: 20.w, height: 6.w, text: "Products", color: primary, fontColor: white),
              SizedBox(height: 2.h,),
              SizedBox(
                width: 100.w,
                height: 71.5.w,
                // color: primaryLight,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productTiles.length,
                        itemBuilder: (context, index){
                          return ProductTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(product: productTiles[index])));
                            },
                            width: 40.w, 
                            height: 40.w, 
                            imgUrl: productTiles[index].imgUrls[0], 
                            title: productTiles[index].name, 
                            price: productTiles[index].price, 
                            description: productTiles[index].description, 
                            onAddToCart: (){});
                        }
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
            ],
          ),
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

