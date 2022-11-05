import 'package:cattle_guru/features/address/ui/screens/edit_address.dart';
import 'package:cattle_guru/features/address/ui/widgets/address_card.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/launch_whatsapp.dart';
import 'package:cattle_guru/utils/helper_functions/phone_call.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("My Addresses", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Icon(Icons.menu_rounded, size: 5.w, color: white,)),
        ),
        actions: [
          InkWell(
            onTap: PhoneCall.makingPhoneCall,
            child: Icon(Icons.phone_rounded, size: 5.w, color: white)),
          SizedBox(width: 5.w,),
          InkWell(
            onTap: LaunchWhatsapp.whatsappLaunch,
            child: SizedBox(
              width: 5.w,
              height: 5.w,
              child: const Image(image: AssetImage("./assets/images/whatsapp_logo.png"))),
          ),
          SizedBox(width: 5.w,),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w,),
                  child: Text("Current Address", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 1.h,),
                AddressCard(
                  onTap: (){}, 
                  isDefault: true, 
                  name: addressTiles[1].name, 
                  address: "${currentAddress.houseNum}, ${currentAddress.village}, ${currentAddress.district}, ${currentAddress.state}, ${currentAddress.pinCode}", 
                  onEditTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address: addressTiles[1])));
                  }, 
                  onDefaultTap: (){}, 
                  onRemoveTap: (){},
                ),
                SizedBox(height: 0.5.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                    width: 90.w,
                    height: 0.5,
                    color: grey,
                  ),
                ),
                SizedBox(height: 1.5.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w,),
                  child: Text("My Addresses", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 1.h,),
                SizedBox(
                  width: 100.w,
                  height: 40.5.h,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: addressTiles.length,
                          itemBuilder: (context, index){
                            return AddressCard(
                              onTap: (){}, 
                              isDefault: addressTiles[index].isDefault, 
                              name: addressTiles[index].name, 
                              address: "${addressTiles[index].houseNum}, ${addressTiles[index].village}, ${addressTiles[index].district}, ${addressTiles[index].state}, ${addressTiles[index].pinCode}", 
                              onEditTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address: addressTiles[index])));
                              }, 
                              onDefaultTap: (){}, 
                              onRemoveTap: (){}
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){
                  Navigator.pushNamed(context, createAddress);
                }, text: "Add Address", fontColor: white, borderColor: primary,),
                SizedBox(height: 2.h,),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index){
          if(index == 0){
            Navigator.pushNamed(context, home);
          }
          if(index == 3){
            Navigator.pushNamed(context, myCart);
          }
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: orangeLight,
        unselectedItemColor: white,
        selectedLabelStyle: globalTextStyle,
        unselectedLabelStyle: globalTextStyle,
        items: items,
        backgroundColor: primary,
      ),
    );
  }
}