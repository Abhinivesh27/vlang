import 'package:flutter/material.dart';
import 'package:vlang/libs/getsysinfo.dart';
import 'package:vlang/ui/splash/splash.dart';

import 'ui/home/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vlang',
      home: SplashScreen(),
    );
  }
}
