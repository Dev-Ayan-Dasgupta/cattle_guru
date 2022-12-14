import 'package:cattle_guru/features/address/ui/screens/edit_address.dart';
import 'package:cattle_guru/features/address/ui/widgets/address_card.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "My Addresses" : "मेरा पता", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('customers').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index) {
                if(snapshot.hasData){
                  if(snapshot.data!.docs[index].get('uid') == currUserId){
                    addresses = snapshot.data!.docs[index].get('addresses').toList();
                    firestoreCurrentAddress = snapshot.data!.docs[index].get('currentAddress');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addresses.isEmpty ? 
                          Column(
                            children: [
                              SizedBox(height: 22.5.h,),
                              SizedBox(
                                width: 33.w, 
                                height: 30.w,
                                child: const Image(image: AssetImage("./assets/images/address_blank.png"), fit: BoxFit.fill,),
                              ),
                              SizedBox(height: 2.h,),
                              Center(
                                child: SizedBox(
                                  width: 75.w,
                                  child: Text("You have no items in your cart, please browse our products to add them here.", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,), textAlign: TextAlign.center,),),
                              ),
                              SizedBox(height: 27.5.h,),
                            ],
                          )
                        :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w,),
                              child: Text(isEnglish ? "Current Address" : "वर्तमान पता", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 1.h,),
                            AddressCard(
                              onTap: (){}, 
                              isDefault: true, 
                              name: firestoreCurrentAddress['name'], 
                              address: "${firestoreCurrentAddress['houseNum']}, ${firestoreCurrentAddress['village']}, ${firestoreCurrentAddress['district']}, ${firestoreCurrentAddress['state']}, ${firestoreCurrentAddress['pinCode']}", 
                              onEditTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address: addressTiles[1], addressIndex: 1, isDefault: false,)));
                              }, 
                              onDefaultTap: (){
                                
                              }, 
                              onRemoveTap: (){},
                            ),
                            SizedBox(height: 0.5.h,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                width: 90.w,
                                height: 0.5,
                                color: grey,
                              ),
                            ),
                            SizedBox(height: 1.5.h,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w,),
                              child: Text(isEnglish ? "My Addresses" : "मेरे पते", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 1.h,),
                            SizedBox(
                              width: 100.w,
                              height: 40.5.h,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: addresses.length,
                                      itemBuilder: (context, index2){
                                        return AddressCard(
                                          onTap: (){
                                            // print("Length: ${addresses.length}");
                                            // print(addresses);
                                          }, 
                                          isDefault: addresses[index2]['isDefault'], 
                                          name: addresses[index2]['name'], 
                                          address: "${addresses[index2]['houseNum']}, ${addresses[index2]['village']}, ${addresses[index2]['district']}, ${addresses[index2]['state']}, ${addresses[index2]['pinCode']}", 
                                          onEditTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address: addresses[index2], addressIndex: index2, isDefault: addresses[index2]['isDefault'],)));
                                          }, 
                                          onDefaultTap: (){
                                            for(int i = 0; i < addresses.length; i++){
                                              if(i == index2){
                                                addresses[i]['isDefault'] = true;
                                              } else {
                                                addresses[i]['isDefault'] = false;
                                              }
                                            }
                                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({'currentAddress': addresses[index2]});
                                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                              'addresses': addresses,
                                            });
                                          }, 
                                          onRemoveTap: (){
                                            for(int i = 0; i < addresses.length; i++){
                                              if(i > index2){
                                                addresses[i]['index']--;
                                              }
                                            }
                                            
                                            if(addresses[index2]['isDefault'] == true){
                                              if(index2 == 0){
                                                addresses[1]['isDefault'] = true;
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'currentAddress': addresses[1],
                                                });
                                              } else {
                                                addresses[0]['isDefault'] = true;
                                                FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                                  'currentAddress': addresses[0],
                                                });
                                              }
                                            }

                                            addresses.remove(addresses[index2]);
                                            FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                              'addresses': addresses,
                                            });
                                          }
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,)
                          ],
                        ),
                        Column(
                          children: [
                            CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                              Navigator.pushNamed(context, createAddress);
                            }, text: isEnglish ? "Add Address" : "पता जोड़ें", fontColor: white, borderColor: primary,),
                            // SizedBox(height: 1.h,),
                          ],
                        ),
                      ],
                    );
                  }
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const SizedBox();
                }
              }
              );
            
            
          }
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
        ]
        ,
        backgroundColor: primary,
      ),
    );
  }
}