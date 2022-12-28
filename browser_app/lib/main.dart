import 'package:browser_app/domain/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TitleProvider>(
      create: (_) => TitleProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const MyHomePage(title: 'Maximus Browser'),
      ),
    );
  }
}
