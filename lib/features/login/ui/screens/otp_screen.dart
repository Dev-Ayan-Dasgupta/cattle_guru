import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_pinput.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h,),
                  const Center(child: Image(image: AssetImage("./assets/images/otp_lock.png"))),
                  SizedBox(height: 5.h,),
                  Text("Verification Code", style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h,),
                  Text("Sent via SMS", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                  SizedBox(height: 2.h,),
                  CustomPinput(onCompleted: (pin){}, pinController: pinController),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Didn't receive OTP?", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                      Text("0:25", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w,),),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Text("Send again", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.h,),
                ],
              ),
            ),
            Column(
              children: [
                CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                  Navigator.pushNamed(context, languages);
                }, text: "Submit OTP", fontColor: white, borderColor: primary,),
                SizedBox(height: 2.h,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}