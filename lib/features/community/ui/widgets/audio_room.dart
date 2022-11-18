import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/community/ui/widgets/experts_tile.dart';
import 'package:cattle_guru/features/community/ui/widgets/podcast_tile.dart';
import 'package:cattle_guru/features/community/ui/widgets/room_tile.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AudioRoom extends StatefulWidget {
  const AudioRoom({super.key});

  @override
  State<AudioRoom> createState() => _AudioRoomState();
}

class _AudioRoomState extends State<AudioRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SizedBox(
              height: 73.5.h,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2.h,),
                            Row(
                              children: [
                                Text(isEnglish ? "Live Rooms" : "लाइव रूम", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            SizedBox(
                              width: 100.w,
                              height: 17.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: roomTiles.length,
                                      itemBuilder: (context, index){
                                        return RoomTile(
                                          bgImrUrl: roomBgImageUrls[index%roomBgImageUrls.length], 
                                          roomTitle: roomTiles[index].title, 
                                          roomDescription: roomTiles[index].description,
                                          membersPhotos: roomTiles[index].membersPhotos,
                                          membersNames: roomTiles[index].membersNames,
                                          startedOn: roomTiles[index].startedOn,
                                        );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Row(
                              children: [
                                Text(isEnglish ? "Experts on Dairy Farming" : "डेयरी फार्मिंग के विशेषज्ञ", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            SizedBox(
                              width: 100.w,
                              height: 26.w,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: experts.length,
                                      itemBuilder: (context, index){
                                        return ExpertsTile(expertImgUrl: experts[index]);
                                      }
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h,),
                            Row(
                              children: [
                                Text(isEnglish ? "Podcasts" : "पॉडकास्ट", style: globalTextStyle.copyWith(color: black, fontSize: 4.w, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            SizedBox(
                              width: 100.w,
                              height: 16.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: podcastTiles.length,
                                      itemBuilder: (context, index){
                                        return PodcastTile(
                                          onTap: (){}, 
                                          podcastImgUrl: podcastTiles[index].podcastImgUrl, 
                                          podcastTitle: podcastTiles[index].podcastTitle, 
                                          podcastDate: podcastTiles[index].podcastDate, 
                                          podcastDuration: podcastTiles[index].podcastDuration, 
                                          onPlay: (){},
                                        );
                                      }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(width: 90.w, height: 15.w, color: primary, 
                            onTap: (){
                              
                            }, 
                            text: isEnglish ? "Start a Room" : "Room शुरू करें", fontColor: white, borderColor: primary,),
                            SizedBox(height: 2.h,),
                          ],
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}