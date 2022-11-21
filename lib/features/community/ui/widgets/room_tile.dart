import 'package:cattle_guru/features/common/widgets/custom_button.dart';
import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({super.key, required this.bgImrUrl, required this.roomTitle, required this.roomDescription, required this.membersPhotos, required this.membersNames, required this.startedOn, required this.onJoin, required this.onEnd,});

  final String bgImrUrl;
  final String roomTitle;
  final String roomDescription;
  final List membersPhotos;
  final List membersNames;
  final DateTime startedOn;
  final VoidCallback onJoin;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Container(
        width: 40.w,
        // height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
          image: DecorationImage(image: AssetImage("./assets/images/$bgImrUrl"), fit: BoxFit.fill)
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(roomTitle, style: globalTextStyle.copyWith(color: white, fontSize: 3.w, fontWeight: FontWeight.bold),),
            SizedBox(height: 1.h,),
            Text(roomDescription, style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w,),),
            SizedBox(height: 1.h,),
            SizedBox(
              width: 36.w,
              height: 6.h,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (membersPhotos.length <= 3) ? membersNames.length : 3,
                      itemBuilder: (context, index){
                        return SizedBox(
                          width: 8.5.w,
                          height: 8.5.w,
                          child: Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Column(
                              children: [
                                Container(
                                  width: 7.5.w,
                                  height: 7.5.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage(membersPhotos[index]), fit: BoxFit.fill),
                                  ),
                                ),
                                SizedBox(height: 0.5.h,),
                                Text(membersNames[index], style: globalTextStyle.copyWith(color: white, fontSize: 2.w), maxLines: 1, overflow: TextOverflow.fade,)
                              ],
                            ),
                          ),
                        );
                      })
                  ),
                  (membersPhotos.length > 3) ? Text("+ ${membersPhotos.length - 3} more", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w),) : SizedBox()
                ],
              ),
            ),
            SizedBox(height: 0.h,),
            Text("Started at ${DateFormat.Hms().format(startedOn)}", style: globalTextStyle.copyWith(color: white, fontSize: 2.5.w,),),
            SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(width: 10.w, height: 5.w, color: white, onTap: onJoin, text: isEnglish ? "Join" : "शामिल हों", fontColor: black, borderColor: white, fontSize: 2.w,),
                CustomButton(width: 10.w, height: 5.w, color: red, onTap: onEnd, text: isEnglish ? "End" : "समाप्त करें", fontColor: white, borderColor: red, fontSize: 2.w,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}