// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/common/info.dart';
import 'package:flutter_motobike_app/sources/auth_source.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:flutter_motobike_app/widgets/button_secondary.dart';
import 'package:flutter_motobike_app/widgets/input.dart';
import 'package:gap/gap.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPassword = TextEditingController();

  createNewAccount() {
    if (editName.text == '') return Info.error('Name must be filled');
    if (editEmail.text == '') return Info.error('Email must be filled');
    if (editPassword.text == '') return Info.error('Password must be filled');

    Info.netral('Loading...');
    AuthSource.signUp(
      editName.text,
      editEmail.text,
      editPassword.text,
    ).then(
      (message) {
        if (message != 'success') return Info.error(message);

        // Success
        Info.success('Success Sign Up');
        Future.delayed(
          Duration(milliseconds: 1500),
          () {
            Navigator.pushReplacementNamed(context, '/signin');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        children: [
          Gap(100),
          Image.asset(
            "assets/logo_text.png",
            width: 171.0,
            height: 38.0,
          ),
          Gap(70),
          Text(
            "Sign Up Account",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0XFF070623),
            ),
          ),
          Gap(30),
          Text(
            "Complete Name",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_profile.png',
            hint: 'Write your real name',
            editingController: editName,
          ),
          Gap(20),
          Text(
            "Email Address",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_email.png',
            hint: 'Write your real email',
            editingController: editEmail,
          ),
          Gap(20),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_key.png',
            hint: 'Write your password',
            editingController: editPassword,
            obsecure: true,
          ),
          Gap(30),
          ButtonPrimary(
            text: 'Create New Account',
            onTap: createNewAccount,
          ),
          Gap(30),
          DottedLine(
            dashGapLength: 6,
            dashLength: 6,
            dashColor: Color(0XFFCECED5),
          ),
          Gap(30),
          ButtonSecondary(
            text: 'Sign In',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
          Gap(30),
        ],
      ),
    );
  }
}
