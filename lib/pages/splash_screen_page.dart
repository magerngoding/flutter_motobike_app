// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:gap/gap.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(70),
          Image.asset(
            "assets/logo_text.png",
            width: 171.0,
            height: 38.0,
            fit: BoxFit.fill,
          ),
          Gap(10),
          Expanded(
            child: Transform.translate(
              offset: Offset(-99, 0),
              child: Image.asset('assets/splash_screen.png'),
            ),
          ),
          Gap(10),
          Text(
            "Drive & Be Happy!",
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color(0XFF070623),
            ),
          ),
          Gap(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "We provide all beautifull motobike for you roadtrip and great memories of life.",
              style: TextStyle(
                height: 1.7,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Color(0XFF070623),
              ),
            ),
          ),
          Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              text: 'Explore Now',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
          ),
          Gap(50),
        ],
      ),
    );
  }
}
