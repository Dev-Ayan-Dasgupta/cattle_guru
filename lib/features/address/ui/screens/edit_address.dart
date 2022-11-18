import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/models/address.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class EditAddressScreen extends StatefulWidget {
  EditAddressScreen({super.key, required this.address, required this.addressIndex, required this.isDefault});

  final Map<String, dynamic> address;
  final int addressIndex;
  bool isDefault;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;
  
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    nameController.text = widget.address['name'];
    houseNumController.text = widget.address['houseNum'];
    villageController.text = widget.address['village'];
    districtController.text = widget.address['district'];
    stateController.text = widget.address['state'];
    pinCodeController.text = widget.address['pinCode'];
  }

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
        title: Text(isEnglish ? "Edit Address" : "पता संपादित करें", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 2.h,),
                    CustomButton(width: 90.w, height: 15.w, color: transparent, 
                      onTap: (){
                        addresses[widget.addressIndex]['name'] = nameController.text;
                        addresses[widget.addressIndex]['houseNum'] = houseNumController.text;
                        addresses[widget.addressIndex]['village'] = villageController.text;
                        addresses[widget.addressIndex]['district'] = districtController.text;
                        addresses[widget.addressIndex]['state'] = stateController.text;
                        addresses[widget.addressIndex]['pinCode'] = pinCodeController.text;
                        addresses[widget.addressIndex]['isDefault'] = widget.isDefault;
                        for(int i = 0; i < addresses.length; i++){
                          if(i == widget.addressIndex){
                            addresses[i]['isDefault'] = true;
                            widget.isDefault = true;
                          } else {
                            addresses[i]['isDefault'] = false;
                          }
                        }
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'currentAddress': addresses[widget.addressIndex]});
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                          'addresses': addresses,
                        });
                      }, 
                      text: isEnglish ? "Set as Default" : "वर्तमान के रूप में सहेजें", fontColor: primary, borderColor: primary,),
                    SizedBox(height: 2.h,),
                    CustomButton(width: 90.w, height: 15.w, color: primary,
                     onTap: (){
                      addresses[widget.addressIndex]['name'] = nameController.text;
                      addresses[widget.addressIndex]['houseNum'] = houseNumController.text;
                      addresses[widget.addressIndex]['village'] = villageController.text;
                      addresses[widget.addressIndex]['district'] = districtController.text;
                      addresses[widget.addressIndex]['state'] = stateController.text;
                      addresses[widget.addressIndex]['pinCode'] = pinCodeController.text;
                      addresses[widget.addressIndex]['isDefault'] = widget.isDefault;
                      FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                        'addresses': addresses,
                      });
                      if(widget.isDefault){
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                        'currentAddress': addresses[widget.addressIndex],
                      });
                      }
                      Navigator.pushNamed(context, myAddresses);
                     }, 
                     text: isEnglish ? "Save Changes" : "परिवर्तनों को सुरक्षित करें", fontColor: white, borderColor: primary,),
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
        items: 
        [
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