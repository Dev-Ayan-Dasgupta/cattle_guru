import 'package:url_launcher/url_launcher.dart';

class PhoneCall{
  static makingPhoneCall() async {
    var url = Uri.parse("tel:+918420516217");
    if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
  }
}