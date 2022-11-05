import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class LaunchWhatsapp{
  static whatsappLaunch() async {

    String whatsapp = '+917668899220';
    String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=Hello Cattle GURU, I have some queries.";
    String whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("Hello Cattle GURU, I have some queries.")}";

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