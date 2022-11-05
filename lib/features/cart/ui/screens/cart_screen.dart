import 'package:cattle_guru/features/cart/ui/widgets/cart_tile.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textfield.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  TextEditingController couponController = TextEditingController();

  @override
  void dispose() { 
    couponController.dispose();
    super.dispose();
  }

  double computeCartVaue(){
    cartValue = 0;
    for(int i = 0; i < cartItems.length; i++){
      cartValue += cartItems[i].product.price * cartItems[i].qty;
    }
    return cartValue;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("My Cart", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: GestureDetector(
          onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: 
            cartItems.isEmpty ? 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 22.5.h,),
                      SizedBox(
                        width: 33.w, 
                        height: 30.w,
                        child: const Image(image: AssetImage("./assets/images/empty_cart.png"), fit: BoxFit.fill,),
                      ),
                      SizedBox(height: 2.h,),
                      Center(
                          child: SizedBox(
                            width: 75.w,
                            child: Text("You have no items in your cart, please browse our products to add them here.", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,), textAlign: TextAlign.center,),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Browse Products", fontColor: white, borderColor: primary),
                      SizedBox(height: 2.h,),
                    ],
                  )
                ],
              )
            : 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 2.h,),
                    SizedBox(
                      width: 100.w,
                      height: 40.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: cartItems.length,
                              itemBuilder: (context, index){
                                return CartTile(
                                  onTap: (){}, 
                                  imgUrl: cartItems[index].product.imgUrls[0], 
                                  productName: cartItems[index].product.name, 
                                  productWeight: cartItems[index].product.weight, 
                                  productPrice: cartItems[index].product.price, 
                                  onSubtract: (){}, 
                                  onAdd: (){},
                                  qty: cartItems[index].qty,
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(width: 57.w, controller: couponController, hintText: "Enter Coupon Code", label: "Coupon Code", keyboardType: TextInputType.text),
                        SizedBox(width: 3.w,),
                        CustomButton(width: 30.w, height: 15.w, color: primary, onTap: (){}, text: "Apply", fontColor: white, borderColor: primary),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                        Text("₹ ${computeCartVaue()}", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Wallet", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                        Text("- ₹ 200.0", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                      ],
                    ),
                    SizedBox(height: 1.h,),Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                        Text("- ₹ 300.0", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Charge", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                        Text("₹ 0", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,)),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      width: 100.w,
                      height: 0.5,
                      color: grey,
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: globalTextStyle.copyWith(color: primary, fontSize: 4.w, fontWeight: FontWeight.bold)),
                        Text("₹ ${computeCartVaue()-300-200}", style: globalTextStyle.copyWith(color: primary, fontSize: 4.w, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Checkout", fontColor: white, borderColor: primary),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
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