import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class VideoThumbnailTile extends StatelessWidget {
  const VideoThumbnailTile({super.key, required this.onTap, required this.width, required this.height, required this.imgUrl, required this.videoName});

  final VoidCallback onTap;
  final double width;
  final double height;
  final String imgUrl;
  final String videoName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 5.w,),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 40.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.fill)
                  ),
                ),
                Container(
                  width: 40.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.w)),
                    color: Colors.black38,
                  ),
                ),
                Icon(Icons.play_arrow_rounded, size: 10.w, color: grey,),
              ],
            ),
            SizedBox(height: 1.h,),
            Text(videoName, style: globalTextStyle.copyWith(color: black, fontSize: 3.w, fontWeight: FontWeight.bold),),
          ],
        ),
      )
    );
  }
}