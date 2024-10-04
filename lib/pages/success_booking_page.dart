// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:gap/gap.dart';

import '../models/bike.dart';
import '../widgets/button_secondary.dart';

class SuccessBookingPage extends StatelessWidget {
  final Bike bike;

  const SuccessBookingPage({
    Key? key,
    required this.bike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Gap(80),
          Text(
            "Success Booking\nHave a Great Ride!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color(0XFF070623),
            ),
          ),
          Gap(50),
          Stack(
            alignment:
                Alignment.bottomCenter, // biar lingkaran nya ke bawah motor
            children: [
              Image.asset(
                "assets/ellipse.png",
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: ExtendedImage.network(
                  bike.image,
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
          Gap(50),
          Text(
            bike.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Text(
            bike.category,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Color(0XFF070623),
            ),
          ),
          Gap(50),
          ButtonPrimary(
            text: 'Booking Order Bike',
            onTap: () {
              // Hapus semua halaman
              Navigator.restorablePushNamedAndRemoveUntil(
                context,
                '/discover',
                (route) => route.settings.name == '/detail',
              );
            },
          ),
          Gap(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ButtonSecondary(
              onTap: () => Navigator.pop(context),
              text: 'View My Orders',
            ),
          ),
        ],
      ),
    );
  }
}
