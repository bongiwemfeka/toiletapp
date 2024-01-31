import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
//import 'package:intro_slider/slide_object.dart';
import 'scan_qr_screen.dart'; // Make sure this import points to the correct file

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final List<Slider> slides = [
    Slide(
      title: 'Welcome to Ferranti Toilet Service App',

      ),
      description: 'Discover amazing features and benefits.',
      styleDescription: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      backgroundColor: const Color.fromARGB(255, 45, 131, 48),
    ),
    Slide(
      title: 'Easy to Use',
      styleTitle: const TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      description: 'Intuitive and user-friendly interface.',
      styleDescription: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      backgroundColor: const Color.fromARGB(255, 45, 131, 48),
    ),
    Slide(
      title: 'Scan QR Codes',
      styleTitle: const TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      description: 'Quickly Scan toilets using QR codes.',
      styleDescription: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      backgroundColor: const Color.fromARGB(255, 45, 131, 48),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IntroSlider(
        slides: slides,
        renderNextBtn: const Text(
          'Next',
          style: TextStyle(color: Colors.white),
        ),
        renderDoneBtn: const Text(
          'Done',
          style: TextStyle(color: Colors.white),
        ),
        onDonePress: () {
          // Navigate to the ScanQRScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScanQRScreen()),
          );
        },
        colorDot: Colors.white,
        colorActiveDot: Colors.green,
        sizeDot: 8.0,
        
      ),
    );
  }
}
