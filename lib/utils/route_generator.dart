import 'package:cattle_guru/features/address/ui/screens/address_list.dart';
import 'package:cattle_guru/features/home/ui/screens/home_screen.dart';
import 'package:cattle_guru/features/login/ui/screens/otp_screen.dart';
import 'package:cattle_guru/features/login/ui/screens/sign_in.dart';
import 'package:cattle_guru/features/profile/ui/screens/intro_details.dart';
import 'package:cattle_guru/features/profile/ui/screens/language_screen.dart';
import 'package:cattle_guru/features/profile/ui/screens/my_profile.dart';
import 'package:cattle_guru/features/profile/ui/screens/my_wallet.dart';
import 'package:cattle_guru/features/profile/ui/screens/refer_and_earn.dart';
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
      case details: return CustomPageTransition(child: const IntroDetailsScreen(), settings: settings,);
      case home: return CustomPageTransition(child: const HomeScreen(), settings: settings,);
      case myProfile: return CustomPageTransition(child: const MyProfileScreen(), settings: settings,);
      case referAndEarn: return CustomPageTransition(child: const ReferandEarnScreen(), settings: settings,);
      case myWallet: return CustomPageTransition(child: const MyWalletScreen(), settings: settings,);
      case myAddresses: return CustomPageTransition(child: const AddressListScreen(), settings: settings,);
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