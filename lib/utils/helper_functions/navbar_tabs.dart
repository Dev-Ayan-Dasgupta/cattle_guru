import 'package:cattle_guru/features/product/ui/screens/product_list.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';

class NavbarTabs{
  static void navigateToTab(BuildContext context, int index){
    if(index == 0){
      Navigator.pushNamed(context, home);
    }
    if(index == 1){
      // Navigator.pushNamed(context, productList);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen(category: "", categoryAux: "", labelsSelected: 0,)));
    }
    if(index == 2){
      Navigator.pushNamed(context, communityHome);
    }
    if(index == 3){
      Navigator.pushNamed(context, myCart);
    }
  }
}