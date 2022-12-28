import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

double _value = 14;

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
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
                            splashRadius: 100,
                            iconSize: 34,
                            color: Colors.white60,
                            onPressed: () {
                              _goUp();
                            },
                            icon: Icon(Icons.arrow_circle_up)),
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
                            icon: Icon(Icons.arrow_circle_down)),
                      ),
                      Positioned(
                        top: 37,
                        child: IconButton(
                            iconSize: 34,
                            color: Colors.white60,
                            onPressed: () {
                              _goLeft();
                            },
                            icon: Icon(Icons.arrow_circle_left)),
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
                            icon: Icon(Icons.arrow_circle_right)),
                      )
                    ],
                  ),
                ),
              )),
          Align(
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
          ),
        ]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: _goHome,
          label: const Text('Home'),
          icon: const Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  Future<void> _goHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goUp() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.scrollBy(0, -200));
  }

  Future<void> _goDown() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.scrollBy(0, 200));
  }

  Future<void> _goLeft() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.scrollBy(-200, 0));
  }

  Future<void> _goRight() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.scrollBy(200, 0));
  }

  Future<void> _zoom(double value) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomTo(value));
  }
}
