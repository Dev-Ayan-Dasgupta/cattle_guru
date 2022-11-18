import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProductListTile extends StatefulWidget {
  ProductListTile({super.key, required this.onTap, required this.imgUrl, required this.productDeliveryDays, required this.date, required this.productName, required this.productWeight, required this.price, required this.mrp, required this.protein, required this.fibre, required this.fat, required this.isCarted, required this.onSubtract, required this.onAdd, required this.qty, required this.width, required this.height, required this.onAddToCart, required this.onBuyNow});

  final VoidCallback onTap;
  final String imgUrl;
  final int productDeliveryDays;
  final DateTime date;
  final String productName;
  final double productWeight;
  final double price;
  final double mrp;
  final double protein;
  final double fibre;
  final double fat;
  bool isCarted;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;
  int qty;
  final double width;
  final double height;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: Container(
          width: 100.w,
          // height: 45.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.w)),
            border: Border.all(color: grey, width: 0.5),
            // boxShadow: [
            //   BoxShadow(
            //     color: grey,
            //     spreadRadius: 3,
            //     blurRadius: 5,
            //     offset: Offset(0, 2),
            //   )
            // ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
          child: Row(
            children: [
              Container(
                width: 33.w,
                height: 33.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.w)),
                  image: DecorationImage(image: AssetImage(widget.imgUrl), fit: BoxFit.fill,),
                ),
              ),
              SizedBox(width: 2.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isEnglish ? "Delivery by ${DateFormat.yMMMMEEEEd().format(widget.date.add(Duration(days: widget.productDeliveryDays)))}" : "${DateFormat.yMMMMEEEEd('hi').format(widget.date.add(Duration(days: widget.productDeliveryDays)))} तक डिलीवरी", style: globalTextStyle.copyWith(color: primary, fontSize: 2.5.w),),
                  SizedBox(height: 1.w,),
                  Text(widget.productName, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.w,),
                  Text(isEnglish ? "Weight: ${widget.productWeight}kg" : "वजन: ${widget.productWeight}kg" , style: globalTextStyle.copyWith(color: black, fontSize: 2.5.w),),
                  SizedBox(height: 1.w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("₹ ${widget.price}", style: globalTextStyle.copyWith(color: primary, fontSize: 3.5.w, fontWeight: FontWeight.bold),),
                      SizedBox(width: 2.5.w,),
                      Container(
                        width: 15.w,
                        height: 5.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(1.w)),
                          color: primaryLight,
                        ),
                        child: Center(child: Text(isEnglish ? "Save ${((1-(widget.price/widget.mrp))*100).toInt()}" : "${((1-(widget.price/widget.mrp))*100).toInt()}% की बचत", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w),),),
                      ),
                      SizedBox(width: 2.5.w,),
                      Text("₹ ${widget.mrp}", style: globalTextStyle.copyWith(color: grey, fontSize: 2.w, decoration: TextDecoration.lineThrough,),),
                    ],
                  ),
                  SizedBox(height: 1.w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularPercentIndicator(
                        radius: 6.w,
                        lineWidth: 1.w,
                        percent: widget.protein/100,
                        center: Column(
                          children: [
                            SizedBox(height: 3.2.w,),
                            Text(isEnglish ? "Protein" : "प्रोटीन", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${widget.protein.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                      SizedBox(width: 2.5.w),
                      CircularPercentIndicator(
                        radius: 6.w,
                        lineWidth: 1.w,
                        percent: widget.fibre/100,
                        center: Column(
                          children: [
                            SizedBox(height: 3.2.w,),
                            Text(isEnglish ? "Fibre" : "रेशा", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${widget.fibre.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                      SizedBox(width: 2.5.w),
                      CircularPercentIndicator(
                        radius: 6.w,
                        lineWidth: 1.w,
                        percent: widget.fat/100,
                        center: Column(
                          children: [
                            SizedBox(height: 3.2.w,),
                            Text(isEnglish ? "Fat" : "वसा", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w, fontWeight: FontWeight.bold),),
                            SizedBox(height: 0.5.w,),
                            Text("${widget.fat.toInt()}%", style: globalTextStyle.copyWith(color: primary, fontSize: 2.w, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        backgroundColor: lightGrey,
                        progressColor: primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w,),
                  Row(
                    children: [
                      widget.isCarted ? 
                  Row(
                    children: [
                      InkWell(
                        onTap: widget.onSubtract,
                        child: Icon(Icons.remove_circle, color: grey, size: 5.w,),
                      ),
                      SizedBox(width: 3.w,),
                      AnimatedFlipCounter(
                        value: widget.qty,
                        textStyle: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 3.w,),
                      InkWell(
                        onTap: widget.onAdd,
                        child: Icon(Icons.add_circle, color: primary, size: 5.w,),
                      ),
                    ],
                  ) :
                  CustomButton(width: widget.width, height: (widget.width/4), color: primary, onTap: widget.onAddToCart, text: isEnglish ?  "Add to Cart" : "कार्ट में जोड़ें", fontColor: white, borderColor: primary, fontSize: 3.w,),
                  SizedBox(width: 2.w,),
                  CustomButton(width: widget.width, height: (widget.width/4), color: primary, onTap: widget.onBuyNow, text: isEnglish ?  "Buy Now" : "अभी खरीदें", fontColor: white, borderColor: primary, fontSize: 3.w,),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}