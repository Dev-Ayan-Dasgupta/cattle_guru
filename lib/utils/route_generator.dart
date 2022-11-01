import 'package:cattle_guru/features/login/ui/screens/otp_screen.dart';
import 'package:cattle_guru/features/login/ui/screens/sign_in.dart';
import 'package:cattle_guru/features/profile/language_screen.dart';
import 'package:cattle_guru/utils/custom_transition.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name){
      case signIn: return CustomPageTransition(child: const SignInScreen(), settings: settings,);
      case otp: return CustomPageTransition(child: const OTPScreen(), settings: settings,);
      case languages: return CustomPageTransition(child: const SelectLanguage(), settings: settings,);
      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('ERROR ROUTE'),
        ),
      );
    });
  }
}