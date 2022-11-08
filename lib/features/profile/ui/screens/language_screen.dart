import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  bool? isEnglish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 10.h,),
                Center(
                  child: SizedBox(
                    width: 33.w,
                    height: 33.w,
                    child: const Image(image: AssetImage("./assets/images/logo.png")))),
                SizedBox(height: 2.h,),
                Text("Cattle GURU", style: globalTextStyle.copyWith(color: black, fontSize: 7.w, fontWeight: FontWeight.bold),),
                SizedBox(height: 5.h,),
                Text("Please select a language", style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                      color: isEnglish! ? primary : primaryLight,
                    ),
                    child: Center(
                      child: Text("English", style: globalTextStyle.copyWith(color: isEnglish! ? white : black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h,),
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
                      color: isEnglish! ? primaryLight : primary,
                    ),
                    child: Center(
                      child: Text("हिन्दी", style: globalTextStyle.copyWith(color: isEnglish! ? black : white, fontSize: 5.w, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                  Navigator.pushNamed(context, details);
                }, text: "Continue", fontColor: white, borderColor: primary,),
                SizedBox(height: 2.h,),
              ],
            )
          ],
        )
      ),
    );
  }
}