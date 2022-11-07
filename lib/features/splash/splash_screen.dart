import 'dart:async';

import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _progressAnimationController;
  late final Animation _progressLengthAnimation;

  @override
  void initState() { 
    super.initState();
    
    _progressAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _progressLengthAnimation = Tween<double>(begin: 0, end: 33.w).animate(
        CurvedAnimation(
            parent: _progressAnimationController, curve: Curves.easeInExpo));
    
    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.forward();

    Timer(const Duration(milliseconds: 3000),
        () => Navigator.pushNamed(context, signIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 33.w,
                height: 33.w,
                child: const Image(image: AssetImage("./assets/images/logo.png"), fit: BoxFit.fill,),
              ),
              SizedBox(height: 2.h,),
              Stack(
                children: [
                  Container(
                    width: 33.w,
                    height: 4,
                    decoration: BoxDecoration(
                      border: Border.all(color: white, width: 0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.w),
                      ),
                      color: transparent,
                    ),
                  ),
                  Container(
                    width: _progressLengthAnimation.value,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.w),
                      ),
                      color: white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}