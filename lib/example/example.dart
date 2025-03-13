import 'package:flutter/material.dart';
import 'package:carousel_text/carousel_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Carousel Text Example")),
        body: const Center(
          child: CarouselText(
            fixedText: "I love",
            rotatingWords: ["Flutter", "Dart", "Coding"],
            animationType: AnimationType.typing, // Change to fade or slide
            typingSpeed: Duration(milliseconds: 100),
            eraseSpeed: Duration(milliseconds: 50),
            stayDuration: Duration(seconds: 2),
            transitionDuration: Duration(milliseconds: 500),
            fixedTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            rotatingTextStyle: TextStyle(fontSize: 24, color: Colors.blue),
            spacing: 10.0,
            loop: true,
            autoStart: true,
          ),
        ),
      ),
    );
  }
}
