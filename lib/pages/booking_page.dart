// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/bike.dart';

class BookingPage extends StatefulWidget {
  final Bike bike;

  const BookingPage({
    Key? key,
    required this.bike,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(30),
          buildSnippetBike()
        ],
      ),
    );
  }

  Widget buildSnippetBike() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      height: 98,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            widget.bike.image,
            width: 90,
            height: 70,
            fit: BoxFit.contain,
          ),
          Gap(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bike.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF070623),
                  ),
                ),
                Text(
                  widget.bike.category,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF070623),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${widget.bike.rating}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF070623),
                ),
              ),
              Gap(4),
              const Icon(
                Icons.star,
                size: 20.0,
                color: Color(0XFFFFBC1C),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onDoubleTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/ic_arrow_back.png",
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Booking",
              textAlign: TextAlign.center, // Pake ini karna di wrap Expanded
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFF070623),
              ),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/ic_more.png",
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
