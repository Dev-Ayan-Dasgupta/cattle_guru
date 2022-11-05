import 'package:cattle_guru/features/common/widgets/custom_textlabel.dart';
import 'package:cattle_guru/features/profile/ui/screens/my_profile.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProfileSnippet extends StatelessWidget {
  const ProfileSnippet({super.key, required this.imgUrl, required this.name, required this.phoneNumber, required this.fontColor, this.onEditPhoto});

  final onEditPhoto;
  final String imgUrl;
  final String name;
  final String phoneNumber;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 25.w,
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: (image != null) ? BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: FileImage(image!), fit: BoxFit.fill),
            ) : BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.fill),
            ),
          ),
          // CircleAvatar(foregroundImage: NetworkImage(imgUrl), radius: 25,),
          SizedBox(width: 5.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: globalTextStyle.copyWith(color: fontColor, fontSize: 4.w, fontWeight: FontWeight.bold,),),
              SizedBox(height: 1.h,),
              Text(phoneNumber, style: globalTextStyle.copyWith(color: fontColor, fontSize: 3.w,),),
              SizedBox(height: 1.h,),
              InkWell(
                onTap: onEditPhoto,
                child: Container(
                  width: 20.w,
                  height: 5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.w)),
                    color: primaryLight,
                  ),
                  child: Center(child: Text("Edit Photo", style: globalTextStyle.copyWith(color: fontColor, fontSize: 3.w)))
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}