import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/features/profile/ui/widgets/profile_snippet.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  TextEditingController pinCodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("My Profile", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 2.h,),
                  const ProfileSnippet(imgUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", name: "Ayan Dasgupta", phoneNumber: "+91-6290986442", fontColor: black),
                  SizedBox(height: 2.h,),
                  // CustomTextField(controller: pinCodeController, hintText: "123321", label: "Pin Code", keyboardType: TextInputType.number),
                  CustomTextField(width: 90.w, controller: pinCodeController, hintText: "123321", label: "Pin Code", keyboardType: TextInputType.number),
                  SizedBox(height: 2.h,),
                  CustomTextField(width: 90.w, controller: villageController, hintText: "Karol Bagh", label: "Village", keyboardType: TextInputType.text),
                  SizedBox(height: 2.h,),
                  CustomTextField(width: 90.w, controller: villageController, hintText: "45-A", label: "House Number", keyboardType: TextInputType.text),
                  SizedBox(height: 2.h,),
                  CustomButton(width: 50.w, height: 15.w, color: primary, onTap: (){}, text: "Save Changes", fontColor: white, borderColor: primary,),
                ],
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: lightRed, onTap: (){}, text: "LOGOUT", fontColor: red, borderColor: red,),
                  SizedBox(height: 2.h),
                ],
              ),
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