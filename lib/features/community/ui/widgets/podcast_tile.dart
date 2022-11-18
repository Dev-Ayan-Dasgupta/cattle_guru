import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class PodcastTile extends StatefulWidget {
  const PodcastTile({super.key, required this.onTap ,required this.podcastImgUrl, required this.podcastTitle, required this.podcastDate, required this.podcastDuration, required this.onPlay});

  final VoidCallback onTap;
  final String podcastImgUrl;
  final String podcastTitle;
  final DateTime podcastDate;
  final double podcastDuration;
  final VoidCallback onPlay;

  @override
  State<PodcastTile> createState() => _PodcastTileState();
}

class _PodcastTileState extends State<PodcastTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 2.5.w),
        child: Container(
          width: 33.w,
          height: 16.h,
          decoration: BoxDecoration(
            border: Border.all(color: primary, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(3.w))
          ),
          child: Column(
            children: [
              Container(
                width: 33.w,
                height: 10.h,
                decoration: BoxDecoration(
                  // border: Border.all(color: primary, width: 0.5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(3.w), topRight: Radius.circular(3.w)),
                  image: DecorationImage(image: NetworkImage(widget.podcastImgUrl), fit: BoxFit.fill),
                  // boxShadow: 
                ),
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.podcastTitle, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 0.5.h,),
                        Text("${DateFormat.MMMd().format(widget.podcastDate)} · ${widget.podcastDuration~/60}m ${(widget.podcastDuration%60).toInt()}s", style: globalTextStyle.copyWith(color: grey, fontSize: 2.5.w,),),
                      ],
                    ),
                    // SizedBox(width: 3.w,),
                    InkWell(
                      onTap: widget.onPlay,
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: primary, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Icon(Icons.play_arrow_rounded, color: primary, size: 4.w,))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}