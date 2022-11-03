import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/common/widgets/custom_drawer.dart';
import 'package:cattle_guru/features/common/widgets/custom_textlabel.dart';
import 'package:cattle_guru/models/product_details.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductDetail product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Product Details", style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.5.h),
                  Center(child: SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: Image(image: AssetImage(widget.product.imgUrl), fit: BoxFit.fill,))),
                  SizedBox(height: 2.h),
                  Text(widget.product.name, style: globalTextStyle.copyWith(color: black, fontSize: 5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("₹ ${widget.product.price}", style: globalTextStyle.copyWith(color: primary, fontSize: 5.w, fontWeight: FontWeight.bold),),
                              SizedBox(width: 2.w,),
                              Text("${((1-((widget.product.price)/(widget.product.mrp)))*100).toInt()}% off", style: globalTextStyle.copyWith(color: grey, fontSize: 2.5.w,),),
                            ],
                          ),
                          SizedBox(height: 0.5.h,),
                          Text("You saved ₹ ${widget.product.mrp - widget.product.price}", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w,),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Weight: ", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                              SizedBox(width: 1.w,),
                              Text("${widget.product.weight} kg", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),),
                            ]
                          ),
                          SizedBox(height: 1.h,),
                          Text("₹ ${(widget.product.price~/widget.product.weight)} per kg", style: globalTextStyle.copyWith(color: grey, fontSize: 3.w,),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Text("Description", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                  // CustomTextLabel(width: 20.w, height: 7.w, text: "Description", color: primary, fontColor: white),
                  SizedBox(height: 1.h,),
                  Text(widget.product.description, style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                  SizedBox(height: 2.h,),
                  Text("Nutrient Information", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 8.w,
                        lineWidth: 1.w,
                        percent: widget.product.protein/100,
                        center: Column(
                          children: [
                            SizedBox(height: 4.5.w,),
                            Text("Protein", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${widget.product.protein.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                      SizedBox(width: 5.w),
                      CircularPercentIndicator(
                        radius: 8.w,
                        lineWidth: 1.w,
                        percent: widget.product.fibre/100,
                        center: Column(
                          children: [
                            SizedBox(height: 4.5.w,),
                            Text("Fibre", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${widget.product.fibre.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                      SizedBox(width: 5.w),
                      CircularPercentIndicator(
                        radius: 8.w,
                        lineWidth: 1.w,
                        percent: widget.product.fat/100,
                        center: Column(
                          children: [
                            SizedBox(height: 4.5.w,),
                            Text("Fat", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${widget.product.fat.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.product.units.toInt() > 0 ?
                        Text("${widget.product.units.toInt()} units in stock", style: globalTextStyle.copyWith(color: primary, fontSize: 3.w, fontWeight: FontWeight.bold),) :
                        Text("Out of stock", style: globalTextStyle.copyWith(color: red, fontSize: 3.w, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  
                ],
              ),
              Column(
                children: [
                  CustomButton(width: 90.w, height: 15.w, color: primary, onTap: (){}, text: "Add to Cart", fontColor: white, borderColor: primary),
                  SizedBox(height: 2.h,),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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