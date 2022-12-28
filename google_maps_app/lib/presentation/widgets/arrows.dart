import 'package:flutter/material.dart';
import 'package:google_maps_app/presentation/pages/my_home_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Arrows extends StatefulWidget {
  @override
  State<Arrows> createState() => _ArrowsState();
}

class _ArrowsState extends State<Arrows> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: FractionalOffset.topRight,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              children: [
                Positioned(
                  left: 36,
                  child: IconButton(
                      iconSize: 34,
                      color: Colors.white60,
                      onPressed: () {
                        _goUp();
                      },
                      icon: const Icon(Icons.arrow_circle_up)),
                ),
                Positioned(
                  left: 36,
                  top: 72,
                  child: IconButton(
                      iconSize: 34,
                      color: Colors.white60,
                      onPressed: () {
                        _goDown();
                      },
                      icon: const Icon(Icons.arrow_circle_down)),
                ),
                Positioned(
                  top: 37,
                  child: IconButton(
                      iconSize: 34,
                      color: Colors.white60,
                      onPressed: () {
                        _goLeft();
                      },
                      icon: const Icon(Icons.arrow_circle_left)),
                ),
                Positioned(
                  left: 72,
                  top: 37,
                  child: IconButton(
                      iconSize: 34,
                      color: Colors.white60,
                      onPressed: () {
                        _goRight();
                      },
                      icon: const Icon(Icons.arrow_circle_right)),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _goUp() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.scrollBy(0, -200));
  }

  Future<void> _goDown() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.scrollBy(0, 200));
  }

  Future<void> _goLeft() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.scrollBy(-200, 0));
  }

  Future<void> _goRight() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.scrollBy(200, 0));
  }
}
