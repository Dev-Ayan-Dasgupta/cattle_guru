import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.onTap, required this.imgUrl, required this.productName, required this.productWeight, required this.productPrice, required this.onSubtract, required this.onAdd, required this.qty, });

  final VoidCallback onTap;
  final String imgUrl;
  final String productName;
  final double productWeight;
  final double productPrice;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;
  final int qty;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: SizedBox(
          width: 100.w,
          height: 17.w,
          child: Row(
            children: [
              SizedBox(
                width: 17.w,
                height: 17.w,
                child: Image(image: AssetImage(widget.imgUrl), fit: BoxFit.fill,),
              ),
              SizedBox(width: 5.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productName, style: globalTextStyle.copyWith(color: black, fontSize: 3.5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.w,),
                  Text("Weight: ${widget.productWeight.toInt()} kg", style: globalTextStyle.copyWith(color: black, fontSize: 3.w,),),
                  SizedBox(height: 2.w,),
                  Text("₹ ${widget.productPrice}", style: globalTextStyle.copyWith(color: black, fontSize: 3.5.w, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(width: 15.w,),
              Column(
                children: [
                  Text("Qty", style: globalTextStyle.copyWith(color: black, fontSize: 3.5.w, fontWeight: FontWeight.bold),),
                  SizedBox(height: 2.w,),
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