import 'dart:io';

import 'package:cattle_guru/features/profile/ui/screens/my_profile.dart';
import 'package:cattle_guru/features/profile/ui/widgets/profile_snippet.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/image_upload.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/helper_functions/sign_out.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

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
    return Drawer(
      backgroundColor: primary,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(220, 32, 146, 80),
            ),
            child: ProfileSnippet(
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
              imgUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", 
              name: userName, 
              phoneNumber: phoneNumber, 
              fontColor: white)
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.person_rounded, color: white, size: 5.w,),
            title: Text("My Profile", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, myProfile);
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.whatsapp_rounded, size: 5.w, color: white,),
            title: Text("Chat", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: LaunchWhatsapp.whatsappLaunch,
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.phone_rounded, size: 5.w, color: white,),
            title: Text("Call", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: PhoneCall.makingPhoneCall,
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.add_business_rounded, size: 5.w, color: white,),
            title: Text("Refer and Earn", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, referAndEarn);
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.wallet_rounded, size: 5.w, color: white,),
            title: Text("My Wallet", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, myWallet);
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.location_on_rounded, size: 5.w, color: white,),
            title: Text("My Addresses", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, myAddresses);
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.shopping_bag_rounded, size: 5.w, color: white,),
            title: Text("My Orders", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, myOrders);
            }
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.g_translate_rounded, size: 5.w, color: white,),
            title: Text("Change Language", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.policy_rounded, size: 5.w, color: white,),
            title: Text("Privacy Policy", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.share_rounded, size: 5.w, color: white,),
            title: Text("Share GURU App", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: () async {
              const urlPreview =
                  "https://play.google.com/store/apps/details?id=com.cattleguru.cattle__guru";
              await Share.share(
                  "Download Cattle GURU app now:\n\n$urlPreview");
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.grade_rounded, size: 5.w, color: white,),
            title: Text("Rate and Feedback", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            dense: true,
            leading: (currUserId != null) ? Icon(Icons.logout_rounded, size: 5.w, color: white,) : Icon(Icons.login_rounded, size: 5.w, color: white,),
            title: Text( (currUserId != null) ? "Logout" : "Login", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              SignOut.signOut(context);
              Navigator.pushNamed(context, signIn);
            },
          ),
        ],
      ),
    );
  }
}