import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomPageTransition extends PageTransition{

  CustomPageTransition({
    required this.child,
    required this.settings,
  }) : super(type: PageTransitionType.rightToLeft, settings: settings, duration: const Duration(milliseconds: 200), reverseDuration: const Duration(milliseconds: 400), curve: Curves.easeInExpo, child: child,);

  @override
  final RouteSettings settings;
  final Widget child;
}