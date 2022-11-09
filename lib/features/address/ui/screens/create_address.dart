import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/fetch_location.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;
  
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

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

  @override
  void dispose() {
    nameController.dispose();
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
                    SizedBox(height: 2.h),
                    CustomTextField(width: 90.w, controller: nameController, hintText: "Ayan Dasgupta", label: "Name", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h),
                    CustomTextField(width: 90.w, controller: houseNumController, hintText: "Mint 1202", label: "House Number", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: villageController, hintText: "Karol Bagh", label: "Village", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: pinCodeController, hintText: "123123", label: "Pin Code", keyboardType: TextInputType.number),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: districtController, hintText: "Delhi", label: "District", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: stateController, hintText: "New Delhi", label: "State", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    InkWell(
                      onTap: () async {
                        position = await FetchLocation.getCurrentLocation();
                        placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
                        Placemark placemark = placeMarks![0];
                        setState(() {
                          houseNumController.text = placemark.street.toString();
                          villageController.text = placemark.subLocality.toString();
                          pinCodeController.text = placemark.postalCode.toString();
                          districtController.text = placemark.subAdministrativeArea.toString();
                          stateController.text = placemark.administrativeArea.toString();
                        });
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
                  children: [
                    SizedBox(height: 2.h,),
                    // CustomButton(width: 90.w, height: 15.w, color: transparent, onTap: (){}, text: "Set as Default", fontColor: primary, borderColor: primary,),
                    // SizedBox(height: 1.h,),
                    CustomButton(width: 90.w, height: 15.w, color: primary, 
                    onTap: (){
                      if(firestoreAddresses.isEmpty){
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                          'currentAddress': 
                          {
                            'name': nameController.text,
                            'houseNum': houseNumController.text,
                            'village': villageController.text,
                            'district': districtController.text,
                            'state': stateController.text,
                            'pinCode': pinCodeController.text,
                            'isDefault': true,
                            'index': firestoreAddresses.length,
                          }
                        });
                      }
                      FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                        'addresses': FieldValue.arrayUnion([
                          {
                            'name': nameController.text,
                            'houseNum': houseNumController.text,
                            'village': villageController.text,
                            'district': districtController.text,
                            'state': stateController.text,
                            'pinCode': pinCodeController.text,
                            'isDefault': (firestoreAddresses.isEmpty) ? true : false,
                            'index': firestoreAddresses.length,
                          }
                        ])
                      });
                      Navigator.pushNamed(context, myAddresses);
                    }, 
                    text: "Add Address", fontColor: white, borderColor: primary,),
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