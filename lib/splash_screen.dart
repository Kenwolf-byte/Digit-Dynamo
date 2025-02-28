import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/pages/homepage.dart'; // Ensure this import is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Animation duration
    );

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth easing curve
      ),
    );

    // Start the animation
    _controller.forward();

    // Navigate to the next page after the splash screen duration
    nextPage();
  }

  void nextPage() {
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const MyHomePage(
            title: 'Digit-Dynamo',
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value, // Apply the scale animation
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage("assets/images/Splas.jpg"),
                    fit: BoxFit
                        .fill, // Ensures the image covers the entire screen
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
