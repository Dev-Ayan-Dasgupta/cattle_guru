import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Change Language" : "भाषा बदलें", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                            SizedBox(height: 7.5.h,),
                            Center(
                              child: SizedBox(
                                width: 33.w,
                                height: 33.w,
                                child: const Image(image: AssetImage("./assets/images/logo.png")))),
                            SizedBox(height: 2.h,),
                            Text(isEnglish ? "Cattle GURU" : "Cattle गुरु", style: globalTextStyle.copyWith(color: black, fontSize: 7.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5.h,),
                            Text(isEnglish ? "Please select a language" : "कृपया कोई भाषा चुनें", style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 2.5.h,),
                            InkWell(
                              onTap: (){
                                if(currUserId != null){
                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'isEnglish': true});
                                }
                                setState(() {
                                  isEnglish = true;
                                });
                              },
                              child: Container(
                                width: 90.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: primary),
                                  borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                  color: isEnglish ? primary : primaryLight,
                                ),
                                child: Center(
                                  child: Text("English", style: globalTextStyle.copyWith(color: isEnglish ? white : black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                            SizedBox(height: 2  .h,),
                            InkWell(
                              onTap: (){
                                if(currUserId != null){
                                  FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'isEnglish': false});
                                }
                                setState(() {
                                  isEnglish = false;
                                });
                              },
                              child: Container(
                                width: 90.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: primary),
                                  borderRadius: BorderRadius.all(Radius.circular(2.w)),
                                  color: isEnglish ? primaryLight : primary,
                                ),
                                child: Center(
                                  child: Text("हिन्दी", style: globalTextStyle.copyWith(color: isEnglish ? black : white, fontSize: 5.w, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(width: 90.w, height: 15.w, color: primary, 
                            onTap: (){
                              if(currUserId != null){
                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'isEnglish': isEnglish});
                              }
                              Navigator.pushNamed(context, home);
                            }, text: isEnglish ? "Save Changes" : "परिवर्तनों को सुरक्षित करें", fontColor: white, borderColor: primary,),
                            SizedBox(height: 2.h,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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