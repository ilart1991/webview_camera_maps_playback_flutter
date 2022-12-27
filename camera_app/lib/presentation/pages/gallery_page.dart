import 'dart:io';

import 'package:flutter/material.dart';

List<String> photosPath = [];

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: photosPath.length,
        itemBuilder: (context, index) {
          return Image(
              fit: BoxFit.fill,
              height: 200,
              image: FileImage(File(photosPath[index])));
        });
  }
}
