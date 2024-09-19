// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BrowseFragment extends StatelessWidget {
  const BrowseFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Browse",
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
