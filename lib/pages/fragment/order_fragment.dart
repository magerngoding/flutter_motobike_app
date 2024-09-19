// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OrderFragment extends StatelessWidget {
  const OrderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Order",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
