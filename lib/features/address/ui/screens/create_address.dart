import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/fetch_location.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
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
        title: Text(isEnglish ? "Create Address" : "पता बनाएँ", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                    CustomTextField(width: 90.w, controller: nameController, hintText: isEnglish ? "Ayan Dasgupta" : "अयन दासगुप्ता", label: isEnglish ? "Name" : "नाम", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h),
                    CustomTextField(width: 90.w, controller: houseNumController, hintText: isEnglish ? "Mint 1202" : "मिंट 1202", label: isEnglish ? "House Number" : "घर का नंबर", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: villageController, hintText: isEnglish ? "Karol Bagh" : "करोल बाग", label: isEnglish ? "Village" : "गाँव", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: pinCodeController, hintText: "123123", label: isEnglish ? "Pin Code" : "पिन कोड", keyboardType: TextInputType.number),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: districtController, hintText: isEnglish ? "Delhi" : "दिल्ली", label: isEnglish ? "District" : "जिला", keyboardType: TextInputType.text),
                    SizedBox(height: 2.h,),
                    CustomTextField(width: 90.w, controller: stateController, hintText: isEnglish ? "New Delhi" : "नई दिल्ली", label: isEnglish ? "State" : "राज्य", keyboardType: TextInputType.text),
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
                          Text(isEnglish? "Detect my location" : "मेरे स्थान का पता लगाएं", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),)
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
                      if(addresses.isEmpty){
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
                            'index': addresses.length,
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
                            'isDefault': (addresses.isEmpty) ? true : false,
                            'index': addresses.length,
                          }
                        ])
                      });
                      Navigator.pushNamed(context, myAddresses);
                    }, 
                    text: isEnglish ? "Add Address" : "पता जोड़ें", fontColor: white, borderColor: primary,),
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