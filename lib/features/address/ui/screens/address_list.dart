import 'package:cattle_guru/features/address/ui/widgets/address_card.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/utils/global_variables.dart';
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
            onTap: (){},
            child: Icon(Icons.phone_rounded, size: 5.w, color: white)),
          SizedBox(width: 5.w,),
          InkWell(
            onTap: (){},
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
              children: [
                SizedBox(height: 5.w,),
                SizedBox(
                  width: 100.w,
                  height: 67.2.h,
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
                              onEditTap: (){}, 
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