import 'package:carousel_slider/carousel_slider.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/login/ui/screens/otp_screen.dart';
import 'package:cattle_guru/features/login/ui/widgets/phone_number_field.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/show_snackbar.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  int _currentCarouselIndex = 0;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 2,
        ),
        width: currentIndex == index ? 15 : 10,
        height: 3,
        decoration: BoxDecoration(
          color: currentIndex == index ? primary : grey,
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
        ),
      );
    });
  }

  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                height: 94.h,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              CarouselSlider(
                                items: carouselImageList.map<Widget>((i){
                                  return Builder(
                                    builder: (context){
                                      return Container(
                                        width: 100.w,
                                        height: 83.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(i), fit: BoxFit.fill),
                                        ),
                                      );
                                    }
                                  );
                                }).toList(), 
                                options: CarouselOptions(
                                  height: 83.w,
                                  aspectRatio: 1/0.83,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  initialPage: 0,
                                  viewportFraction: 1,
                                  onPageChanged: (index, timed) {
                                    setState(() {
                                      _currentCarouselIndex = index;
                                    });
                                  }
                                ),
                              ),
                              SizedBox(height: 1.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: indicators(
                                    carouselImageList.length, _currentCarouselIndex),
                              ),
                              SizedBox(height: 2.h,),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(isEnglish ? "Enter your phone number" : "???????????? ???????????? ???????????? ???????????? ????????????", style: globalTextStyle.copyWith(fontSize: 5.w, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                PhoneNumberField(phoneController: phoneController),
                                SizedBox(height: 1.h),
                                Text(isEnglish ? "OTP will be sent on this number." : "?????? ???????????? ?????? ??????????????? ???????????? ??????????????????", style: globalTextStyle.copyWith(fontSize: 3.w,),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                              // Navigator.pushNamed(context, otp);
                              (phoneController.text.length == 10) ?
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phoneNumber: "+91${phoneController.text}"))) 
                                : ShowSnackbar.showSnackBar(context, isEnglish ? "Enter a valid 10 digit phone number." : "?????? ??????????????? 10 ??????????????? ?????? ???????????? ???????????? ???????????? ???????????????");
                            }, text: isEnglish ? "Get OTP" : "??????????????? ????????????????????? ????????????", fontColor: white, borderColor: primary,),
                            SizedBox(height: 1.h,),
                            Text(isEnglish ? "By signing up, you agree to our Terms and Services" : "???????????? ?????? ????????????, ?????? ??????????????? ?????????????????? ?????? ???????????? ???????????? ????????? ?????? ??????????????????", style: globalTextStyle.copyWith(fontSize: 2.5.w,),),
                            SizedBox(height: 2.h,)
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}