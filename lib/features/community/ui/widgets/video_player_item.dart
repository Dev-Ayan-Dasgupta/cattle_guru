import 'package:cattle_guru/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {

  late VideoPlayerController videoPlayerController;

  @override
  void initState() { 
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)..initialize().then((value) {
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
    });
  }

  @override
  void dispose() { 
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 75.h,
      child: VideoPlayer(videoPlayerController),
    );
  }
}