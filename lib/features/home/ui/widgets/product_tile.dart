import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({super.key, required this.width, required this.height, required this.imgUrl, required this.title, required this.price, required this.description, required this.onAddToCart, required this.onTap});

  final VoidCallback onTap;
  final double width;
  final double height;
  final String imgUrl;
  final String title;
  final double price;
  final String description;
  final VoidCallback onAddToCart;

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
              SizedBox(height: 1.h,),
              Text(widget.title, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
              SizedBox(height: 1.h,),
              Text("₹ ${widget.price}", style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
              SizedBox(height: 1.h,),
              Text(widget.description, style: globalTextStyle.copyWith(color: black, fontSize: 3.w,), maxLines: 2, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 1.h,),
              CustomButton(width: widget.width, height: (widget.width/5.5), color: primary, onTap: widget.onAddToCart, text: "Add to Cart", fontColor: white),
            ],
          ),
        ),
      ),
    );
  }
}