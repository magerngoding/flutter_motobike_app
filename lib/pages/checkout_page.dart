// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/bike.dart';

class CheckoutPage extends StatefulWidget {
  final Bike bike;
  final String startDate;
  final String endDate;

  const CheckoutPage({
    Key? key,
    required this.bike,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
