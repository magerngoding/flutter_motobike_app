// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/bike.dart';

class PinPage extends StatefulWidget {
  final Bike bike;

  const PinPage({
    Key? key,
    required this.bike,
  }) : super(key: key);

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
