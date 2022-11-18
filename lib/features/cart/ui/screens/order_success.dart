import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> with TickerProviderStateMixin {

  late AnimationController animationController;

  @override
  void initState() { 
    super.initState();
    animationController = AnimationController(vsync: this, 
    //duration: Duration(seconds: 3)
    );
    animationController.addStatusListener((status) async {
      if(status == AnimationStatus.completed){
        Navigator.pushNamed(context, myOrders);
        animationController.reset();
      }
     });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              Lottie.asset("./assets/lottie/order_success.json", repeat: false, controller: animationController, 
                onLoaded: (composition){
                  animationController.duration = const Duration(milliseconds: 2500);
                  // animationController.duration = composition.duration;
                  animationController.forward();
                },
              ),
              SizedBox(height: 2.h,),
              Text(isEnglish ? "Congratulations, your order has been placed." : "बधाई हो, आपका ऑर्डर दे दिया गया है।", style: globalTextStyle.copyWith(color: primary, fontSize: 7.w, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
            ],
          ),
        ),
      )
    );
  }
}