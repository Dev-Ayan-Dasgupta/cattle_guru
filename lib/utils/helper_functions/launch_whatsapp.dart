import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class LaunchWhatsapp{
  static whatsappLaunch() async {

    String whatsapp = '+918420516217';
    String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=Hello Cattle GURU";
    String whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("Hello Cattle GURU")}";

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      } else {
        print("whatsapp not installed");
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        print("whatsapp not installed");
      }
    }

  }
}