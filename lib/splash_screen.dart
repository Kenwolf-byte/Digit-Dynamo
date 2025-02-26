import 'dart:async';

import 'package:calculator/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Timer(const Duration(seconds: 15), () {
      Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
        return const MyHomePage(
          title: 'Digit-Dynamo',
        );
      }));
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 70,
            bottom: 20,
            right: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: size.height,
                  width: size.width,
                  // color: Colors.blue[100],
                  child: const Text("Joy Calculator")),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0800,
            // width: size.width,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/images/1.jpeg"))),
          ),
        ],
      ),
    );
  }
}
