import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/features/community/ui/widgets/experts_tile.dart';
import 'package:cattle_guru/features/community/ui/widgets/podcast_tile.dart';
import 'package:cattle_guru/features/community/ui/widgets/room_tile.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cattle_guru/utils/helper_functions/jitsi_meet_functions.dart';
import 'package:cattle_guru/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AudioRoom extends StatefulWidget {
  const AudioRoom({super.key});

  @override
  State<AudioRoom> createState() => _AudioRoomState();
}

class _AudioRoomState extends State<AudioRoom> {

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
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
                              height: 19.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('audio-rooms').snapshots(),
                                      builder: (context, snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
                                          itemBuilder: (context, index){
                                            String roomDescription = (snapshot.data! as dynamic).docs[index]['roomDescription'];
                                            List membersNames = (snapshot.data! as dynamic).docs[index]['membersNames'];
                                            List membersPhotos = (snapshot.data! as dynamic).docs[index]['membersPhotos'];
                                            DateTime startedAt = (snapshot.data! as dynamic).docs[index]['startedAt'].toDate();
                                            String id = (snapshot.data! as dynamic).docs[index].id;
                                            String createdBy = (snapshot.data! as dynamic).docs[index]['createdBy'];
                                            return RoomTile(
                                              bgImrUrl: roomBgImageUrls[index%roomBgImageUrls.length], 
                                              roomTitle: (snapshot.data! as dynamic).docs[index]['roomName'],
                                              // roomTiles[index].title, 
                                              roomDescription: (snapshot.data! as dynamic).docs[index]['roomDescription'],
                                              membersPhotos: (snapshot.data! as dynamic).docs[index]['membersPhotos'],
                                              membersNames: (snapshot.data! as dynamic).docs[index]['membersNames'],
                                              startedOn: (snapshot.data! as dynamic).docs[index]['startedAt'].toDate(),
                                              onEnd: (){
                                                if(currUserId == createdBy){
                                                  JitsiMeetMethods.removeMeeting(id: id);
                                                }
                                              },
                                              onJoin: (){
                                                membersNames.add(userName);
                                                membersPhotos.add(profileImgUrl);
                                                JitsiMeetMethods.joinMeeting(
                                                  roomName: (snapshot.data! as dynamic).docs[index]['roomName'],
                                                  isAudioMuted: true,
                                                  username: userName, 
                                                  profilePhotoUrl: profileImgUrl, 
                                                  membersNames: membersNames,
                                                  membersPhotos: membersPhotos,
                                                  id: (snapshot.data! as dynamic).docs[index].id);
                                              },
                                            );
                                          }
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
                            SizedBox(height: 22.h,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 2.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(width: 44.w, height: 15.w, color: primary, 
                    onTap: (){
                      Navigator.pushNamed(context, joinRoom);
                    }, 
                    text: isEnglish ? "Join a Room" : "Room में शामिल हों", fontColor: white, borderColor: primary,),
                    SizedBox(width: 2.w,),
                    CustomButton(width: 44.w, height: 15.w, color: primary, 
                    onTap: (){
                      Navigator.pushNamed(context, createRoom);
                    }, 
                    text: isEnglish ? "Start a Room" : "Room शुरू करें", fontColor: white, borderColor: primary,),
                    SizedBox(height: 2.h,),
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