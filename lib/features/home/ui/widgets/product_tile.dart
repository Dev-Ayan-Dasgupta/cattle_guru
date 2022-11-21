import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductTile extends StatefulWidget {
  ProductTile({super.key, required this.width, required this.height, required this.imgUrl, required this.title, required this.price, required this.description, required this.onAddToCart, required this.isCarted, required this.onTap, required this.onAdd, required this.onSubtract, required this.qty, required this.onBuyNow});

  final VoidCallback onTap;
  final double width;
  final double height;
  final String imgUrl;
  final String title;
  final double price;
  final String description;
  bool isCarted;
  final VoidCallback onAddToCart;
  final VoidCallback onAdd;
  final VoidCallback onSubtract;
  int qty;
  final VoidCallback onBuyNow;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: SizedBox(
          width: widget.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.w)),
                  image: DecorationImage(image: AssetImage(widget.imgUrl), fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: 2.w,),
              Text(widget.title, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
              SizedBox(height: 2.w,),
              Text("₹ ${widget.price}", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
              SizedBox(height: 2.w,),
              Text(widget.description, style: globalTextStyle.copyWith(color: black, fontSize: 3.w,), maxLines: 2, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 2.w,),
              widget.isCarted ? 
              Row(
                children: [
                  InkWell(
                    onTap: widget.onSubtract,
                    child: Icon(Icons.remove_circle, color: grey, size: 7.15.w,),
                  ),
                  SizedBox(width: 3.w,),
                  AnimatedFlipCounter(
                    value: widget.qty,
                    textStyle: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 3.w,),
                  InkWell(
                    onTap: widget.onAdd,
                    child: Icon(Icons.add_circle, color: primary, size: 7.15.w,),
                  ),
                ],
              )
              :
              CustomButton(width: widget.width, height: (widget.width/5.5), color: primary, onTap: widget.onAddToCart, text: isEnglish ?  "Add to Cart" : "कार्ट में जोड़ें", fontColor: white, borderColor: primary,),
              SizedBox(height: 2.w,),
              CustomButton(width: widget.width, height: (widget.width/5.5), color: primary, onTap: widget.onBuyNow, text: isEnglish ?  "Buy Now" : "अभी खरीदें", fontColor: white, borderColor: primary),
            ],
          ),
        ),
      ),
    );
  }
}