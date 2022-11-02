import 'package:cattle_guru/features/profile/ui/widgets/profile_snippet.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primary,
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(220, 32, 146, 80),
            ),
            child: ProfileSnippet(imgUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", name: "Ayan Dasgupta", phoneNumber: "+91-6290986442", fontColor: white)
          ),
          ListTile(
            leading: Icon(Icons.person_rounded, color: white, size: 5.w,),
            title: Text("My Profile", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, myProfile);
            },
          ),
          ListTile(
            leading: Icon(Icons.whatsapp_rounded, size: 5.w, color: white,),
            title: Text("Chat", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.phone_rounded, size: 5.w, color: white,),
            title: Text("Call", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.add_business_rounded, size: 5.w, color: white,),
            title: Text("Refer and Earn", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, referAndEarn);
            },
          ),
          ListTile(
            leading: Icon(Icons.wallet_rounded, size: 5.w, color: white,),
            title: Text("My Wallet", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
            onTap: (){
              Navigator.pushNamed(context, myWallet);
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on_rounded, size: 5.w, color: white,),
            title: Text("My Addresses", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_rounded, size: 5.w, color: white,),
            title: Text("My Orders", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.g_translate_rounded, size: 5.w, color: white,),
            title: Text("Change Language", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.policy_rounded, size: 5.w, color: white,),
            title: Text("Privacy Policy", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.share_rounded, size: 5.w, color: white,),
            title: Text("Share GURU App", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
          ListTile(
            leading: Icon(Icons.grade_rounded, size: 5.w, color: white,),
            title: Text("Rate and Feedback", style: globalTextStyle.copyWith(color: white, fontSize: 4.w)),
          ),
        ],
      ),
    );
  }
}