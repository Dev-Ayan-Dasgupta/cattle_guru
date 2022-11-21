import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/jitsi_meet_functions.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../utils/helper_functions/launch_whatsapp.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {

  TextEditingController roomNameController = TextEditingController();
  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  List members = [];

  bool isValid = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Join a Room" : "Room में शामिल हों", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 40.w,
                        height: 40.w,
                        child: Image(image: AssetImage("./assets/images/audio_room.png")),
                      ),
                      SizedBox(height: 5.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(controller: roomNameController, hintText: isEnglish ? "Weekly Discussion room" : "साप्ताहिक चर्चा बैठक", label: isEnglish ? "Room Name" : "कमरे का नाम", keyboardType: TextInputType.text, width: 90.w, 
                            onChanged : (val){
                              setState(() {
                                
                              });
                            }
                          ),
                          SizedBox(height: 1.h),
                          Text(isEnglish ? "Enter a valid room name" : "एक वैध Room का नाम दर्ज करें", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w),),
                          // isValid ? Text( isEnglish ? "You have entered a valid room name" : "आपने एक वैध Room नाम दर्ज किया है", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w)) : Text(isEnglish ? "Enter a valid room name" : "एक वैध Room का नाम दर्ज करें", style: globalTextStyle.copyWith(color: lightRed, fontSize: 3.w),),
                          // CustomTextField(controller: roomDescriptionController, hintText: isEnglish ? "This is a meeting for upskilling farmers" : "यह किसानों को ऐप का उपयोग करने के तरीके सिखाने के लिए एक बैठक है", label: isEnglish ? "Room Description" : "कमरे के विवरण", keyboardType: TextInputType.text, width: 90.w),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 26.h,),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('audio-rooms').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return SizedBox();
                          }
                          return SizedBox(
                            width: 100.w,
                            height: 15.w,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
                                    itemBuilder: (context, index){
                                      if((snapshot.data! as dynamic).docs[index]['roomName'] == roomNameController.text){
                                        isValid = true;
                                        List membersNames = (snapshot.data! as dynamic).docs[index]['membersNames'];
                                        List membersPhotos = (snapshot.data! as dynamic).docs[index]['membersPhotos'];
                                        String id = (snapshot.data! as dynamic).docs[index].id;
                                        return CustomButton(width: 90.w, height: 15.w, color: primary,
                                          onTap: (){
                                            JitsiMeetMethods.joinMeeting(
                                              roomName: roomNameController.text,
                                              isAudioMuted: true, 
                                              username: userName, 
                                              profilePhotoUrl: profileImgUrl, 
                                              membersNames: membersNames, 
                                              membersPhotos: membersPhotos, 
                                              id: id,
                                            );
                                          }, 
                                          text: isEnglish ? "Join a Room" : "Room में शामिल हों", fontColor: white, borderColor: primary); 
                                      }
                                      return SizedBox();
                                    }
                                  ),
                                ),
                              ],
                            ),
                          );
                          
                        }
                      ),
                      SizedBox(height: 2.h,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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