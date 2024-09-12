// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
    return const Scaffold();
  }
}
