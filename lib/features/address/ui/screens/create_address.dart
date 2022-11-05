import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {

  TextEditingController houseNumController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  @override
  void dispose() {
    houseNumController.dispose();
    villageController.dispose();
    districtController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Create Address", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: GestureDetector(
          onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 3.h),
                    CustomTextField(width: 90.w, controller: houseNumController, hintText: "Mint 1202", label: "House Number", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: villageController, hintText: "Karol Bagh", label: "Village", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: pinCodeController, hintText: "123123", label: "Pin Code", keyboardType: TextInputType.number),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: districtController, hintText: "Delhi", label: "District", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: stateController, hintText: "New Delhi", label: "State", keyboardType: TextInputType.text),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 2.h,),
                    CustomButton(width: 90.w, height: 15.w, color: transparent, onTap: (){}, text: "Set as Default", fontColor: primary, borderColor: primary,),
                    SizedBox(height: 2.h,),
                    CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Add Address", fontColor: white, borderColor: primary,),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ],
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