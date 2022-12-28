// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_app/presentation/widgets/my_buttons.dart';
import 'package:video_app/presentation/widgets/my_slider.dart';
import 'package:video_app/presentation/widgets/my_video_player.dart';
import 'package:video_player/video_player.dart';

late VideoPlayerController controller;
bool visible = true;
bool activeSlider = false;
late Duration duration;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4')
      ..initialize().then((_) {
        controller.addListener(() {
          setState(() {});
        });
        duration = controller.value.duration;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    controller.setLooping(true);

    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: controller.value.isInitialized
              ? Stack(children: [
                  const MyVideoPlayer(),
                  MyButtons(),
                  MySlider(),
                ])
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
