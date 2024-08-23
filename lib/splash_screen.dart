import 'dart:async';

import 'package:calculator/pages/homepage.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextPage();
  }

  nextPage() {
    Timer(const Duration(seconds: 30), () {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (context) {
        return const MyHomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/2.jpeg"))),
    );
  }
}
