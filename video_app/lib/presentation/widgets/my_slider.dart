import 'package:flutter/material.dart';

import '../pages/my_home_page.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double? currentPosition;
  Future<double?> getCurrentPosition() async {
    controller.position.then((value) {
      return currentPosition = value!.inSeconds.toDouble();
    });
    return currentPosition;
  }

  setInvisible() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (activeSlider == false) {
          visible = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: FutureBuilder(
        future: getCurrentPosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Visibility(
              visible: visible,
              child: Container(
                color: Colors.black12,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: currentPosition!,
                      onChangeEnd: (value) => setState(() {
                        activeSlider = false;
                        setInvisible();
                      }),
                      onChanged: (value) {
                        setState(() {
                          activeSlider = true;
                          currentPosition = value;
                          controller.position.then((value) {
                            value = Duration(seconds: currentPosition!.round());
                            controller.seekTo(value);
                          });
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        children: [
                          Text(controller.value.position.inSeconds.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                          const Spacer(),
                          Text(
                            duration.inSeconds.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
