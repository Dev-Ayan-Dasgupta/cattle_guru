import 'dart:io';

import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/features/profile/ui/widgets/profile_snippet.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/image_upload.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/helper_functions/sign_out.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

File? image;

class _MyProfileScreenState extends State<MyProfileScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  TextEditingController pinCodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();

  @override
  void dispose() {
    pinCodeController.dispose();
    villageController.dispose();
    houseNoController.dispose();
    super.dispose();
  }

  Future<File?> selectImageFromCamera() async {
    image = await ImageUpload.pickImage(context, ImageSource.camera, cropSquareImage);
    setState(() {
      });
    return image;
  }

  Future<File?> selectImageFromGallery() async {
    image = await ImageUpload.pickImage(context, ImageSource.gallery, cropSquareImage);
    setState(() {
      });
    return image;
  }

  Future<File?> cropSquareImage(File imageFile) async =>
    await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("My Profile", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('customers').snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
                itemBuilder: (context, index){
                  if(snapshot.hasData){
                    if(snapshot.data!.docs[index].get('uid') == currUserId){
                      userName = snapshot.data!.docs[index].get('name');
                      phoneNumber = snapshot.data!.docs[index].get('phoneNumber');
                      profileImgUrl = snapshot.data!.docs[index].get('profileImgUrl');
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 2.h,),
                                ProfileSnippet(
                                  onEditPhoto: (){
                                    showModalBottomSheet(
                                      context: context, 
                                      builder: (context){
                                        return Container(
                                          height: 11.h,
                                          width: 100.w,
                                          color: white,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 2.h,),
                                                InkWell(
                                                  onTap: () async {
                                                    await selectImageFromCamera();
                                                    Navigator.pop(context);
                                                    // print(image);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.camera_rounded, size: 4.w, color: black,),
                                                      SizedBox(width: 5.w,),
                                                      Text("Camera", style: globalTextStyle.copyWith(color: black, fontSize: 4.w),),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 2.h,),
                                                InkWell(
                                                  onTap: () async {
                                                    await selectImageFromGallery();
                                                    Navigator.pop(context);
                                                    // print(image);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.collections_rounded, size: 4.w, color: black,),
                                                      SizedBox(width: 5.w,),
                                                      Text("Gallery", style: globalTextStyle.copyWith(color: black, fontSize: 4.w),),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  }, 
                                  imgUrl: profileImgUrl, name: userName, phoneNumber: phoneNumber, fontColor: black),
                                  SizedBox(height: 2.h,),
                                  CustomTextField(width: 90.w, controller: pinCodeController, hintText: "123321", label: "Pin Code", keyboardType: TextInputType.number),
                                  SizedBox(height: 2.h,),
                                  CustomTextField(width: 90.w, controller: villageController, hintText: "Karol Bagh", label: "Village", keyboardType: TextInputType.text),
                                  SizedBox(height: 2.h,),
                                  CustomTextField(width: 90.w, controller: villageController, hintText: "45-A", label: "House Number", keyboardType: TextInputType.text),
                                  SizedBox(height: 20.h,),
                                  CustomButton(width: 90.w, height: 15.w, color: primary, 
                                  onTap: (){
                                    
                                  }, 
                                  text: "Save Changes", fontColor: white, borderColor: primary,),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: 1.h),
                                CustomButton(width: 90.w, height: 15.w, color: lightRed, 
                                onTap: (){
                                  SignOut.signOut(context);
                                  Navigator.pushNamed(context, signIn);
                                }, 
                                text: "LOGOUT", fontColor: red, borderColor: red,),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ],
                        ),
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