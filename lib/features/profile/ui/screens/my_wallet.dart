import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textlabel.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("My Wallet", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Icon(Icons.menu_rounded, size: 5.w, color: white,)),
        ),
        actions: [
          InkWell(
            onTap: (){},
            child: Icon(Icons.phone_rounded, size: 5.w, color: white)),
          SizedBox(width: 5.w,),
          InkWell(
            onTap: (){},
            child: SizedBox(
              width: 5.w,
              height: 5.w,
              child: const Image(image: AssetImage("./assets/images/whatsapp_logo.png"))),
          ),
          SizedBox(width: 5.w,),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: (100*(158/360)).w,
                      child: const Image(image: AssetImage("./assets/images/my_wallet_banner.png"), fit: BoxFit.fill,),
                    ),
                    Positioned(
                      left: 25.w,
                      top: 12.5.w,
                      child: Column(
                        children: [
                          Text("Your available balance is", style: globalTextStyle.copyWith(color: white, fontSize: 4.w,),),
                          SizedBox(height: 2.w),
                          Text("₹ 200", style: globalTextStyle.copyWith(color: white, fontSize: 8.w, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text("Money will get deducted from wallet upon purchases.", style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),),
                ),
                SizedBox(height: 2.h,),
                CustomTextLabel(width: 35.w, height: 7.w, text: "Transaction History", color: primary, fontColor: white),
                // SizedBox(height: 1.h,),
                Container(
                  width: 100.w,
                  height: 34.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index){
                            return ListTile(
                              leading: const Image(image: AssetImage("./assets/images/wallet_leading.png"), fit: BoxFit.fill,),
                              title: Text("Sign up", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                              subtitle: Text("22 October, 2022", style: globalTextStyle.copyWith(color: black, fontSize: 2.5.w,),),
                              trailing: Text("₹ 100", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                            );
                          })
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
              ],
            ),
            Column(
              children: [
                CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Browse Products", fontColor: white, borderColor: primary,),
                SizedBox(height: 2.h),
              ],
            ),
          ],
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