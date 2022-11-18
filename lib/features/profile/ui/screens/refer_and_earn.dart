import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ReferandEarnScreen extends StatefulWidget {
  const ReferandEarnScreen({super.key});

  @override
  State<ReferandEarnScreen> createState() => _ReferandEarnScreenState();
}

class _ReferandEarnScreenState extends State<ReferandEarnScreen> {

  TextEditingController referController = TextEditingController();

  @override
  void dispose() {
    referController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Refer and Earn", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
          child: GestureDetector(
            onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
            behavior: HitTestBehavior.opaque,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    const Center(child: Image(image: AssetImage("./assets/images/refer_and_earn.png"))),
                    SizedBox(height: 5.h),
                    Text(isEnglish ? "Cattle GURU" : "Cattle गुरु", style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                    SizedBox(height: 2.h),
                    Text(isEnglish ? "Help your dairy friend to get best quality Cattle Feed at their home." : "अपने डेयरी मित्र को सर्वश्रेष्ठ पाने में मदद करें उनके घर पर गुणवत्तापूर्ण पशु चारा।", style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: isEnglish ? "You will get " : "आपको प्रत्येक के लिए ",
                            style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),
                            children: <TextSpan>[
                              TextSpan(text: isEnglish ? "Rs 100 " : "100 रुपय ", style: globalTextStyle.copyWith(color: primary, fontSize: 5.w, fontWeight: FontWeight.bold),),
                              TextSpan(text: isEnglish ? "for every referral." : "मिलेंगे रेफरल।", style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),),
                            ]
                          ), 
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomTextField(width: 90.w, controller: referController, hintText: isEnglish ? "Enter customer ID" : "ग्राहक आईडी डालें", label: isEnglish ? "Customer ID" : "ग्राहक आईडी", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h),
                    CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Whatsapp", fontColor: white, borderColor: primary,)
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