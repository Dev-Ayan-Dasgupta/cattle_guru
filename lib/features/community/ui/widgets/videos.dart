import 'package:cattle_guru/features/community/ui/widgets/circle_animation.dart';
import 'package:cattle_guru/features/community/ui/widgets/video_player_item.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:video_player/video_player.dart';

class VideosTab extends StatefulWidget {
  const VideosTab({super.key});

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: shortVideoUrls.length,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          return Stack(
            children: [
              VideoPlayerItem(videoUrl: shortVideoUrls[index].videoUrl),
              Column(
                children: [
                  SizedBox(height: 12.5.h,),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(shortVideoUrls[index].name, style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
                                Text(shortVideoUrls[index].description, style: globalTextStyle.copyWith(color: white, fontSize: 3.w,),),
                                SizedBox(height: 2.h,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 10.w,
                          margin: EdgeInsets.only(top: 20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.thumb_up_rounded, color: white, size: 6.w,),
                                  SizedBox(height: 0.5.h,),
                                  Text(shortVideoUrls[index].likes.toString(), style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
                                  SizedBox(height: 2.5.h,),
                                  Icon(Icons.thumb_down_rounded, color: white, size: 6.w,),
                                  SizedBox(height: 0.5.h,),
                                  Text(shortVideoUrls[index].dislikes.toString(), style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
                                  SizedBox(height: 2.5.h,),
                                  Icon(Icons.comment_rounded, color: white, size: 6.w,),
                                  SizedBox(height: 0.5.h,),
                                  Text(shortVideoUrls[index].comments.toString(), style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
                                  SizedBox(height: 2.5.h,),
                                  Icon(Icons.share_rounded, color: white, size: 6.w,),
                                  SizedBox(height: 0.5.h,),
                                  Text("Share", style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
                                  SizedBox(height: 2.5.h,),
                                  Icon(Icons.more_horiz_rounded, color: white, size: 6.w,),
                                ],
                              ),
                              // CircleAnimation(child: child)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        }
      )
      // SafeArea(
      //   child: Container(
      //     width: 100.w,
      //     height: 75.h,
      //     decoration: BoxDecoration(
      //       image: DecorationImage(image: AssetImage("./assets/images/giphy.webp"), fit: BoxFit.fill),
      //     ),
      //     child: Stack(
      //       children: [
      //         Positioned(
      //           right: 5.w,
      //           bottom: 10.h,
      //           child: Column(
      //             children: [
      //               Icon(Icons.thumb_up_rounded, color: white, size: 4.w,),
      //               SizedBox(height: 2.w,),
      //               Text("150K", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w),),
      //               SizedBox(height: 5.w,),
      //               Icon(Icons.thumb_down_rounded, color: white, size: 4.w,),
      //               SizedBox(height: 2.w,),
      //               Text("Dislike", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w),),
      //               SizedBox(height: 5.w,),
      //               Icon(Icons.comment_rounded, color: white, size: 4.w,),
      //               SizedBox(height: 2.w,),
      //               Text("558", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w),),
      //               SizedBox(height: 5.w,),
      //               Icon(Icons.share_rounded, color: white, size: 4.w,),
      //               SizedBox(height: 2.w,),
      //               Text("Share", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w),),
      //               SizedBox(height: 5.w,),
      //               Icon(Icons.more_horiz_rounded, color: white, size: 4.w,),
      //               // SizedBox(height: 2.w,),
      //               // Text("Share", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w),),
      //             ],
      //           ),
      //         ),
      //       ],
      //     )
      //   ),
      // ),
    );
  }
}