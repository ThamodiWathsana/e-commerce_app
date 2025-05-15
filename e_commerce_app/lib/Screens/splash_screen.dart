// File: lib/Screens/splash_screen.dart

import 'welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to welcome screen after 2 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-right corner decoration - properly sized
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 184, 180, 180),
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Bottom-left corner decoration - larger as per design
          Positioned(
            bottom: -90,
            left: -90,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 184, 180, 180),
                  width: 1.5,
                ),
              ),
            ),
          ),

          // Top "insightlancer" text - positioned to match design
          Positioned(
            top: 50.0,
            left: 30.0,
            child: Text(
              'insightlancer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade300,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // Bottom "insightlancer" text - correctly positioned next to bottom corner
          Positioned(
            bottom: 80.0,
            left: 160.0,
            child: Text(
              'insightlancer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade300,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // Center fashion logo and text
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF7E614A), // Brown color for the circle
                  ),
                  child: const Center(
                    child: Text(
                      'f',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Playfair Display',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Row(
                  children: [
                    Text(
                      'fashion',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Playfair Display',
                      ),
                    ),
                    Text(
                      '.',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7E614A), // Brown color for the dot
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
