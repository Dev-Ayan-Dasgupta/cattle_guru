import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/fetch_location.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class IntroDetailsScreen extends StatefulWidget {
  const IntroDetailsScreen({super.key});

  @override
  State<IntroDetailsScreen> createState() => _IntroDetailsScreenState();
}

class _IntroDetailsScreenState extends State<IntroDetailsScreen> {

  Position position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  List<Placemark>? placeMarks;

  TextEditingController nameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    pinCodeController.dispose();
    villageController.dispose();
    super.dispose();
  }

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Details", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
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
                    SizedBox(height: 5.h,),
                    CustomTextField(width: 90.w, controller: nameController, hintText: "Enter your name", label: "Name", keyboardType: TextInputType.name,),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: pinCodeController, hintText: "Enter your pin code", label: "Pin Code", keyboardType: TextInputType.number,),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: villageController, hintText: "Enter your village name", label: "Village", keyboardType: TextInputType.text,),
                    SizedBox(height: 2.h,),
                    InkWell(
                      onTap: () async {
                        position = await FetchLocation.getCurrentLocation();
                        placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
                        Placemark placemark = placeMarks![0];
                        pinCodeController.text = placemark.postalCode.toString();
                        villageController.text = placemark.subLocality.toString();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.my_location_rounded, color: primary, size: 3.w,),
                            SizedBox(width: 1.w,),
                            Text("Detect my location", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),)
                          ],
                        ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(width: 90.w, height: 15.w, color: primary, onTap: () async {
                      if(currUserId != null){
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'name': nameController.text});
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).
                        update({'currentAddress': 
                          {
                            'name': nameController.text,
                            'houseNum': "",
                            'village': villageController.text,
                            'district': "",
                            'state': "",
                            'pinCode': pinCodeController.text,
                            'isDefault': true,
                            'index': 0,
                          },
                        });
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).
                        update({'addresses': FieldValue.arrayUnion([
                            {
                            'name': nameController.text,
                            'houseNum': "",
                            'village': villageController.text,
                            'district': "",
                            'state': "",
                            'pinCode': pinCodeController.text,
                            'isDefault': true,
                            'index': 0,
                            },
                          ]), 
                        });
                        Navigator.pushNamed(context, home);
                      }
                    }, text: "Continue", fontColor: white, borderColor: primary,),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}