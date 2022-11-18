import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/navbar_tabs.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  const YouTubePlayerScreen({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {

  late YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: false,
      ),
    );
  }

  @override
  void initState() { 
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        width: 100.w,
      ),
      builder: (context, player){
        return Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: primary,
            title: Text(isEnglish ? "Watch Video" : "वीडियो देखें", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
            centerTitle: true,
            leading: Builder(
              builder: (context) => InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Icon(Icons.menu_rounded, size: 7.5.w, color: white,)),
            ),
            actions: [
              InkWell(
                onTap: PhoneCall.makingPhoneCall,
                child: Icon(Icons.phone_rounded, size: 7.5.w, color: white)),
              SizedBox(width: 7.5.w,),
              InkWell(
                onTap: LaunchWhatsapp.whatsappLaunch,
                child: SizedBox(
                  width: 7.5.w,
                  height: 7.5.w,
                  child: const Image(image: AssetImage("./assets/images/whatsapp_logo.png"))),
              ),
              SizedBox(width: 7.5.w,),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player,
              SizedBox(height: 2.h,),
              Text(widget.title, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 1,
            onTap: (index){
              NavbarTabs.navigateToTab(context, index);
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: orangeLight,
            unselectedItemColor: white,
            selectedLabelStyle: globalTextStyle,
            unselectedLabelStyle: globalTextStyle,
            items: 
            [
                BottomNavigationBarItem(
                  backgroundColor: primary,
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: isEnglish ? "Home" : "घर",
                ),
                BottomNavigationBarItem(
                  backgroundColor: primary,
                  icon: Icon(
                    Icons.local_shipping_rounded,
                  ),
                  label: isEnglish ? "Feed" : "चारा",
                ),
                BottomNavigationBarItem(
                  backgroundColor: primary,
                  icon: Icon(
                    Icons.people_rounded,
                  ),
                  label: isEnglish ? "Community" : "समुदाय",
                ),
                BottomNavigationBarItem(
                  backgroundColor: primary,
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                  ),
                  label: isEnglish ? "Cart" : "कार्ट",
                ),     
            ],
            backgroundColor: primary,
          ),
        );
      },
       
    );
  }
}