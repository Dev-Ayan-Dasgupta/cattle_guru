import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class EnterReferralScreen extends StatefulWidget {
  const EnterReferralScreen({super.key});

  @override
  State<EnterReferralScreen> createState() => _EnterReferralScreenState();
}

class _EnterReferralScreenState extends State<EnterReferralScreen> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  TextEditingController referralCodeController = TextEditingController();

  @override
  void dispose() { 
    referralCodeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(isEnglish ? "Referral" : "रेफ़रल", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
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
                    allUsersId.add(snapshot.data!.docs[index].get('uid'));
                    if(snapshot.data!.docs[index].get('uid') == currUserId){
                      currentUserName = snapshot.data!.docs[index].get('name');
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15.h,),
                                  Center(
                                    child: SizedBox(
                                      width: 40.w,
                                      height: 40.w,
                                      child: const Image(image: AssetImage("./assets/images/referral.png"), fit: BoxFit.fill,),
                                    ),
                                  ),
                                  SizedBox(height: 5.h,),
                                  Text(isEnglish ? "Enter Referral Code" : "रेफ़रल कोड दर्ज करें", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 1.5.h,),
                                  CustomTextField(controller: referralCodeController, hintText: "JvpXGE53p9O4X0mhpoREtw3Ar2w2", label: "Referral Code", keyboardType: TextInputType.text, width: 90.w),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    children: [
                                      Text(isEnglish ? "You and your friend will each receive " : "साइन अप करने पर आपको और आपके दोस्त को ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                                      Text("₹ 100 ", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                                      Text(isEnglish ? "when you sign up." : "मिलेंगे।", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 23.h,),
                                  CustomButton(width: 90.w, height: 15.w, color: primary, 
                                  onTap: (){
                                    if(allUsersId.contains(referralCodeController.text) && (referralCodeController.text != currUserId)){
                                      FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                        'walletBalance': FieldValue.increment(100),
                                      });
                                      FirebaseFirestore.instance.collection('customers').doc(referralCodeController.text).update({
                                        'walletBalance': FieldValue.increment(100),
                                      });
                                      FirebaseFirestore.instance.collection('customers').doc(referralCodeController.text).update({
                                        'transactions': FieldValue.arrayUnion([
                                          {
                                            'purpose': "Sign up by $currentUserName",
                                            'date': DateTime.now(),
                                            'amount': 100,
                                          }
                                        ]),
                                      });
                                      FirebaseFirestore.instance.collection('customers').doc(currUserId).update({
                                        'transactions': FieldValue.arrayUnion([
                                          {
                                            'purpose': "Self Sign up",
                                            'date': DateTime.now(),
                                            'amount': 100,
                                          }
                                        ]),
                                      });
                                    }
                                    
                                    Navigator.pushNamed(context, home);
                                  }, 
                                  text: isEnglish ? "Submit" : "दर्ज करें", fontColor: white, borderColor: primary),
                                  SizedBox(height: 2.h,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // else {
                    //   return SizedBox();
                    // }
                  }
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const SizedBox();
                  }
                },
              ); 
            }
          ),
        )
      )
    );
  }
}