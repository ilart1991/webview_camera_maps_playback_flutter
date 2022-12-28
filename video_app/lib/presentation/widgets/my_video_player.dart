import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../pages/my_home_page.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({super.key});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  if (visible) {
                    visible = false;
                  } else {
                    visible = true;
                  }
                });
              },
              child: VideoPlayer(controller))),
    );
  }
}
