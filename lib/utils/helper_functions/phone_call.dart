import 'package:url_launcher/url_launcher.dart';

class PhoneCall{
  static makingPhoneCall() async {
    var url = Uri.parse("tel:+917668899220");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}