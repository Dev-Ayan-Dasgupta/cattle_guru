import 'package:cattle_guru/features/community/ui/widgets/video_player_item.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class VideosTab extends StatefulWidget {
  const VideosTab({super.key});

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {

  PageController pageController = PageController(initialPage: 0, viewportFraction: 1);

  final String? currUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('shorts').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: SizedBox(
              width: 5.w,
              height: 5.w,
              child: CircularProgressIndicator()));
          }
          // return ListView.builder(
          //   itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
          //   itemBuilder: (context, index0){

          //   });
          return PageView.builder(
            itemCount: (snapshot.data != null) ? snapshot.data!.docs.length : 0,
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: (snapshot.data! as dynamic).docs[index]['videoUrl']),
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
                                    Text((snapshot.data! as dynamic).docs[index]['name'], style: globalTextStyle.copyWith(color: white, fontSize: 5.w, fontWeight: FontWeight.bold),),
                                    Text((snapshot.data! as dynamic).docs[index]['description'], style: globalTextStyle.copyWith(color: white, fontSize: 3.w,),),
                                    SizedBox(height: 2.h,),
                                  ],
                                ),
                              ),
                            ),
                            (index != (snapshot.data!.docs.length -1)) ?
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: InkWell(
                                      onTap: () {
                                        // if(index != (shortVideoUrls.length -1)){
                                          
                                        // }
                                        pageController.animateToPage(index+1, duration: const Duration(seconds: 1), curve: Curves.easeIn);
                                      },
                                      child: Icon(Icons.keyboard_double_arrow_up_rounded, color: white,))
                                    // Text("Hello", style: globalTextStyle.copyWith(color: white),),
                                  ),
                                  SizedBox(height: 2.h,)
                                ],
                              ),
                            ) : SizedBox(),
                            Container(
                              width: 10.w,
                              margin: EdgeInsets.only(top: 10.h, right: 5.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          if(likedShorts.contains((snapshot.data! as dynamic).docs[index].id)){
                                            likedShorts.remove((snapshot.data! as dynamic).docs[index].id);
                                            FirebaseFirestore.instance. collection('customers').doc(currUserId).update({
                                              'likedShorts' : likedShorts,
                                            });
                                            FirebaseFirestore.instance.collection('shorts').doc((snapshot.data! as dynamic).docs[index].id).update({
                                              'likes': FieldValue.increment(-1),
                                            });
                                          } else {
                                            likedShorts.add((snapshot.data! as dynamic).docs[index].id);
                                            FirebaseFirestore.instance. collection('customers').doc(currUserId).update({
                                              'likedShorts' : likedShorts,
                                            });
                                            FirebaseFirestore.instance.collection('shorts').doc((snapshot.data! as dynamic).docs[index].id).update({
                                              'likes': FieldValue.increment(1),
                                            });
                                            if(dislikedShorts.contains((snapshot.data! as dynamic).docs[index].id)){
                                              dislikedShorts.remove((snapshot.data! as dynamic).docs[index].id);
                                              FirebaseFirestore.instance. collection('customers').doc(currUserId).update({
                                                'dislikedShorts' : dislikedShorts,
                                              });
                                              FirebaseFirestore.instance.collection('shorts').doc((snapshot.data! as dynamic).docs[index].id).update({
                                              'dislikes': FieldValue.increment(-1),
                                            });
                                            }
                                          }
                                        },
                                        child: Icon(Icons.thumb_up_rounded, color: white, size: 6.w,)),
                                      SizedBox(height: 0.5.h,),
                                      Text((snapshot.data! as dynamic).docs[index]['likes'].toString(), style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
                                      SizedBox(height: 2.5.h,),
                                      InkWell(
                                        onTap: (){
                                          if(dislikedShorts.contains((snapshot.data! as dynamic).docs[index].id)){
                                            dislikedShorts.remove((snapshot.data! as dynamic).docs[index].id);
                                            FirebaseFirestore.instance. collection('customers').doc(currUserId).update({
                                              'dislikedShorts' : dislikedShorts,
                                            });
                                            FirebaseFirestore.instance.collection('shorts').doc((snapshot.data! as dynamic).docs[index].id).update({
                                              'dislikes': FieldValue.increment(-1),
                                            });
                                          } else {
                                            dislikedShorts.add((snapshot.data! as dynamic).docs[index].id);
                                            FirebaseFirestore.instance. collection('customers').doc(currUserId).update({
                                              'dislikedShorts' : dislikedShorts,
                                            });
                                            FirebaseFirestore.instance.collection('shorts').doc((snapshot.data! as dynamic).docs[index].id).update({
                                              'dislikes': FieldValue.increment(1),
                                            });
                                            if(likedShorts.contains((snapshot.data! as dynamic).docs[index].id)){
                                              likedShorts.remove((snapshot.data! as dynamic).docs[index].id);
                                              FirebaseFirestore.instance. collection('customers').doc(currUserId).update({
                                                'likedShorts' : likedShorts,
                                              });
                                              FirebaseFirestore.instance.collection('shorts').doc((snapshot.data! as dynamic).docs[index].id).update({
                                              'likes': FieldValue.increment(-1),
                                            });
                                            }
                                          }
                                        },
                                        child: Icon(Icons.thumb_down_rounded, color: white, size: 6.w,)),
                                      SizedBox(height: 0.5.h,),
                                      Text((snapshot.data! as dynamic).docs[index]['dislikes'].toString(), style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
                                      SizedBox(height: 2.5.h,),
                                      Icon(Icons.comment_rounded, color: white, size: 6.w,),
                                      SizedBox(height: 0.5.h,),
                                      Text((snapshot.data! as dynamic).docs[index]['comments'].toString(), style: globalTextStyle.copyWith(color: white, fontSize: 3.w),),
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