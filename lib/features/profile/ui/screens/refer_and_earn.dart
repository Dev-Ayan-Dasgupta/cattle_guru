import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
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
                    Text("Cattle GURU", style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                    SizedBox(height: 2.h),
                    Text("Help your dairy friend to get best quality Cattle Feed at their home.", style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "You will get ",
                            style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),
                            children: <TextSpan>[
                              TextSpan(text: "Rs 100 ", style: globalTextStyle.copyWith(color: primary, fontSize: 5.w, fontWeight: FontWeight.bold),),
                              TextSpan(text: "for every referral.", style: globalTextStyle.copyWith(color: black, fontSize: 4.w,),),
                            ]
                          ), 
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomTextField(width: 90.w, controller: referController, hintText: "Enter customer ID", label: "Customer ID", keyboardType: TextInputType.text),
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