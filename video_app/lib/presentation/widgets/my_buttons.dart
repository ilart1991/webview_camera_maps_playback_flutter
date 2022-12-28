import 'package:flutter/material.dart';

import '../pages/my_home_page.dart';

class MyButtons extends StatefulWidget {
  const MyButtons({super.key});

  @override
  State<MyButtons> createState() => _MyButtonsState();
}

class _MyButtonsState extends State<MyButtons> {
  setInvisible() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (activeSlider == false) {
          visible = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: visible,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.replay_10),
              onPressed: () {
                controller.position.then((value) {
                  controller.seekTo(value! - const Duration(seconds: 10));
                  setInvisible();
                });
              },
            ),
            IconButton(
              color: Colors.white,
              iconSize: 55,
              icon: controller.value.isPlaying
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
              onPressed: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
                setInvisible();
              },
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.forward_10),
              onPressed: () {
                controller.position.then((value) {
                  controller.seekTo(value! + const Duration(seconds: 10));
                  setInvisible();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
