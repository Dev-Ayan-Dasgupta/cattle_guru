import 'dart:async';

import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_pinput.dart';
import 'package:cattle_guru/models/customer.dart';
import 'package:cattle_guru/models/order_model.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/show_snackbar.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  TextEditingController pinController = TextEditingController();

  String verificationCode = "";

  phoneLogin(BuildContext context, String? phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ShowSnackbar.showSnackBar(context, e.message!);
      },
      codeSent: (String verificationID, int? resendToken) {
        verificationCode = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        //verificationCode = verificationID;
      },
      timeout: const Duration(seconds: 120),
    );
  }

  late Timer _timer;
  int start = 60;
  String resendMessage = "";
  //bool timerStarted = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start == 0) {
        setState(() {
          _timer.cancel();
          (start == 0)
              ? resendMessage = "Haven't received OTP? Click here to resend."
              : (start >= 10)
                  ? resendMessage = "Resend OTP in 00:$start"
                  : resendMessage = "Resend OTP in 00:0$start";
        });
      } else {
        setState(() {
          start--;
          (start == 0)
              ? resendMessage = "Haven't received OTP? Click here to resend."
              : (start >= 10)
                  ? resendMessage = "Resend OTP in 00:$start"
                  : resendMessage = "Resend OTP in 00:0$start";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    phoneLogin(context, widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
          behavior: HitTestBehavior.opaque,
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
                    Text("Sent via SMS to ${widget.phoneNumber}", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                    SizedBox(height: 2.h,),
                    CustomPinput(
                      onSubmitted: (pin) async {
                        try {
                          UserCredential cred = await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationCode, smsCode: pin!));

                          final doc = await FirebaseFirestore.instance.
                                        collection('customers').
                                        doc(cred.user!.uid).
                                        get();
                          
                          bool doesDocExist = doc.exists;

                          if(doesDocExist == false){
                            Customer customer = Customer(
                              uid: cred.user!.uid, 
                              phoneNumber: cred.user!.phoneNumber!, 
                              isEnglish: true,
                              profileImgUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                              name: "", 
                              transactions: [],
                              walletBalance: 0, 
                              cartValue: 0, 
                              cart: [],
                              currentOrders: [],
                              orderHistory: [], 
                              currentAddress: {},
                              addresses: [],
                            );
          
                            await FirebaseFirestore.instance.
                            collection('customers').
                            doc(cred.user!.uid).
                            set(customer.toMap());

                            Navigator.pushNamed(context, languages);
                          } else {
                            Navigator.pushNamed(context, home);
                          }

                        } catch (e) {
                          ShowSnackbar.showSnackBar(context, e.toString());
                        }
                      }, 
                      pinController: pinController),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if(start == 0){
                              phoneLogin(context, widget.phoneNumber);
                              setState(() {
                                startTimer();
                              });
                            }
                          },
                          child: Text(resendMessage, style: globalTextStyle.copyWith(color: primary, fontSize: 3.w,),)),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: primary, onTap: () async {
                    try {
                      UserCredential cred = await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationCode, smsCode: pinController.text));

                      final doc = await FirebaseFirestore.instance.
                                        collection('customers').
                                        doc(cred.user!.uid).
                                        get();
                      bool doesDocExist = doc.exists;

                      if(doesDocExist == false){
                        Customer customer = Customer(
                          uid: cred.user!.uid, 
                          phoneNumber: cred.user!.phoneNumber!, 
                          isEnglish: true,
                          profileImgUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                          name: "", 
                          transactions: [],
                          walletBalance: 0, 
                          cartValue: 0, 
                          cart: [],
                          currentOrders: [],
                          orderHistory: [],
                          currentAddress: {},
                          addresses: [],
                        );

                        await FirebaseFirestore.instance.
                            collection('customers').
                            doc(cred.user!.uid).
                            set(customer.toMap());

                        Navigator.pushNamed(context, languages);
                      } else {
                        Navigator.pushNamed(context, home);
                      }
  
                    } catch (e) {
                      ShowSnackbar.showSnackBar(context, e.toString());
                      print(e.toString());
                    }
                  }, text: "Submit OTP", fontColor: white, borderColor: primary,),
                  SizedBox(height: 2.h,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}