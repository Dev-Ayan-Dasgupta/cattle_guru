import 'package:cattle_guru/features/address/ui/screens/address_list.dart';
import 'package:cattle_guru/features/address/ui/screens/create_address.dart';
import 'package:cattle_guru/features/community/ui/screens/community_home.dart';
import 'package:cattle_guru/features/cart/ui/screens/cart_screen.dart';
import 'package:cattle_guru/features/cart/ui/screens/order_success.dart';
import 'package:cattle_guru/features/cart/ui/screens/payment_options_screen.dart';
import 'package:cattle_guru/features/home/ui/screens/home_screen.dart';
import 'package:cattle_guru/features/login/ui/screens/otp_screen.dart';
import 'package:cattle_guru/features/login/ui/screens/sign_in.dart';
import 'package:cattle_guru/features/orders/ui/screen/order_screen.dart';
import 'package:cattle_guru/features/product/ui/screens/product_list.dart';
import 'package:cattle_guru/features/profile/ui/screens/change_language.dart';
import 'package:cattle_guru/features/profile/ui/screens/enter_referral.dart';
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
      // case otp: return CustomPageTransition(child: const OTPScreen(), settings: settings,);
      case languages: return CustomPageTransition(child: const SelectLanguage(), settings: settings,);
      case referral: return CustomPageTransition(child: const EnterReferralScreen(), settings: settings,);
      case details: return CustomPageTransition(child: const IntroDetailsScreen(), settings: settings,);
      case home: return CustomPageTransition(child: const HomeScreen(), settings: settings,);
      case myProfile: return CustomPageTransition(child: const MyProfileScreen(), settings: settings,);
      case referAndEarn: return CustomPageTransition(child: const ReferandEarnScreen(), settings: settings,);
      case myWallet: return CustomPageTransition(child: const MyWalletScreen(), settings: settings,);
      case myAddresses: return CustomPageTransition(child: const AddressListScreen(), settings: settings,);
      case createAddress: return CustomPageTransition(child: const CreateAddressScreen(), settings: settings,);
      case paymentMode: return CustomPageTransition(child: const PaymentOptionsScreen(), settings: settings,);
      // case productList: return CustomPageTransition(child: const ProductListScreen(category: ,), settings: settings,);
      case myCart: return CustomPageTransition(child: const CartScreen(), settings: settings,);
      case myOrders: return CustomPageTransition(child: const OrdersScreen(), settings: settings,);
      case orderSuccess: return CustomPageTransition(child: const OrderSuccessScreen(), settings: settings,);
      case changeLanguage: return CustomPageTransition(child: const ChangeLanguageScreen(), settings: settings,);
      case communityHome: return CustomPageTransition(child: const CommunityHomeScreen(), settings: settings,);
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