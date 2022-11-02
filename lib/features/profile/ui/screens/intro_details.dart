import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class IntroDetailsScreen extends StatefulWidget {
  const IntroDetailsScreen({super.key});

  @override
  State<IntroDetailsScreen> createState() => _IntroDetailsScreenState();
}

class _IntroDetailsScreenState extends State<IntroDetailsScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Details", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 5.h,),
                  CustomTextField(controller: nameController, hintText: "Enter your name", label: "Name", keyboardType: TextInputType.name,),
                  SizedBox(height: 2.h,),
                  CustomTextField(controller: pinCodeController, hintText: "Enter your pin code", label: "Pin Code", keyboardType: TextInputType.number,),
                  SizedBox(height: 2.h,),
                  CustomTextField(controller: villageController, hintText: "Enter your village name", label: "Village", keyboardType: TextInputType.text,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                    Navigator.pushNamed(context, home);
                  }, text: "Continue", fontColor: white),
                  SizedBox(height: 2.h,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}