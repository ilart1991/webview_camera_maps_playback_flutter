import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../pages/my_home_page.dart';

double _value = 14;

class MySlider extends StatefulWidget {
  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 65),
        child: Container(
          color: Colors.white60,
          height: 30,
          width: 140,
          child: Slider(
            min: 0,
            max: 19,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
                _zoom(value);
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> _zoom(double value) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.zoomTo(value));
  }
}
