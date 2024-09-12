// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChattingPage extends StatefulWidget {
  final String uid;
  final String userName;

  const ChattingPage({
    Key? key,
    required this.uid,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
