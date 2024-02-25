import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlang/service/controller.dart';
import 'package:vlang/ui/home/home.dart';
import 'package:vlang/ui/home/service.dart';
import 'package:vlang/ui/splash/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => CompilerController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        title: 'Vlang',
        home: SplashScreen(),
      ),
    );
  }
}
