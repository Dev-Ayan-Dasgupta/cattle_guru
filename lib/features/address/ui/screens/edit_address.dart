import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/models/address.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
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
        title: Text("Edit Address", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
                    CustomButton(width: 90.w, height: 15.w, color: transparent, 
                      onTap: (){
                        firestoreAddresses[widget.addressIndex]['name'] = nameController.text;
                        firestoreAddresses[widget.addressIndex]['houseNum'] = houseNumController.text;
                        firestoreAddresses[widget.addressIndex]['village'] = villageController.text;
                        firestoreAddresses[widget.addressIndex]['district'] = districtController.text;
                        firestoreAddresses[widget.addressIndex]['state'] = stateController.text;
                        firestoreAddresses[widget.addressIndex]['pinCode'] = pinCodeController.text;
                        firestoreAddresses[widget.addressIndex]['isDefault'] = widget.isDefault;
                        for(int i = 0; i < firestoreAddresses.length; i++){
                          if(i == widget.addressIndex){
                            firestoreAddresses[i]['isDefault'] = true;
                            widget.isDefault = true;
                          } else {
                            firestoreAddresses[i]['isDefault'] = false;
                          }
                        }
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'currentAddress': firestoreAddresses[widget.addressIndex]});
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                          'addresses': firestoreAddresses,
                        });
                      }, 
                      text: "Set as Default", fontColor: primary, borderColor: primary,),
                    SizedBox(height: 2.h,),
                    CustomButton(width: 90.w, height: 15.w, color: primary,
                     onTap: (){
                      firestoreAddresses[widget.addressIndex]['name'] = nameController.text;
                      firestoreAddresses[widget.addressIndex]['houseNum'] = houseNumController.text;
                      firestoreAddresses[widget.addressIndex]['village'] = villageController.text;
                      firestoreAddresses[widget.addressIndex]['district'] = districtController.text;
                      firestoreAddresses[widget.addressIndex]['state'] = stateController.text;
                      firestoreAddresses[widget.addressIndex]['pinCode'] = pinCodeController.text;
                      firestoreAddresses[widget.addressIndex]['isDefault'] = widget.isDefault;
                      FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                        'addresses': firestoreAddresses,
                      });
                      if(widget.isDefault){
                        FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                        'currentAddress': firestoreAddresses[widget.addressIndex],
                      });
                      }
                      Navigator.pushNamed(context, myAddresses);
                     }, 
                     text: "Save Changes", fontColor: white, borderColor: primary,),
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