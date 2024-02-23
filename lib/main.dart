import 'package:flutter/material.dart';
import 'package:vlang/ui/splash/splash.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: 'Vlang',
      home: SplashScreen(),
    );
  }
}
