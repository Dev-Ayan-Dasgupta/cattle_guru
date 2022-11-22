import 'package:cattle_guru/features/community/ui/widgets/audio_room.dart';
import 'package:cattle_guru/models/audio_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiMeetMethods{
  static void createMeeting(
    {
    required String createdBy,
    required String roomName,
    required String roomDescription,
    required bool isAudioMuted,
    required String username,
    required String profilePhotoUrl,
    required List membersNames,
    required List membersPhotos,
    required List currentUserIds,
  }
  ) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name = username;
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userAvatarURL = profilePhotoUrl
        ..audioOnly = true
        ..audioMuted = isAudioMuted;

      AudioRoomModel audioRoom = AudioRoomModel(
        createdBy: createdBy,
        roomName: roomName, 
        roomDescription: roomDescription, 
        membersNames: membersNames,
        membersPhotos: membersPhotos, 
        membersUids: currentUserIds,
        startedAt: DateTime.now(),
      );

      await FirebaseFirestore.instance.collection('audio-rooms').doc().set(audioRoom.toMap());

      await JitsiMeet.joinMeeting(options); 

    } catch (e) {
      print(e); 
    }
  }

  static void joinMeeting(
    {
    required String roomName,
    required bool isAudioMuted,
    required String username,
    required String profilePhotoUrl,
    required List membersNames,
    required List membersPhotos,
    required String id,
  }
  ) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name = username;
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userAvatarURL = profilePhotoUrl
        ..audioOnly = true
        ..audioMuted = isAudioMuted;
      
      await FirebaseFirestore.instance.collection('audio-rooms').doc(id).update({
        'roomName': roomName,
        'membersNames': membersNames,
        'membersPhotos': membersPhotos,
      });

      await JitsiMeet.joinMeeting(options); 
    } catch (e) {
      print(e); 
    }
  }

  static void removeMeeting(
    {
      required String id
    }
  ) async {
    await FirebaseFirestore.instance.collection('audio-rooms').doc(id).delete();
    
  }
}
