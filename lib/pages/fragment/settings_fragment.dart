// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import

import 'dart:developer';

import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/models/account.dart';
import 'package:gap/gap.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  logout() {
    DSession.removeUser().then(
      (remove) {
        if (!remove) return;

        Navigator.pushReplacementNamed(context, '/signin');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Gap(30 + MediaQuery.of(context).padding.top),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'My Settings',
            style: TextStyle(
              fontSize: 24.0,
              color: Color(0XFF070623),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          child: Column(
            children: [
              buildProfile(),
              Gap(30),
              buildItemSetting(
                'assets/ic_profile.png',
                'Edit Profile',
                null,
              ),
              Gap(20),
              buildItemSetting(
                'assets/ic_wallet.png',
                'My Digital Wallet',
                null,
              ),
              Gap(20),
              buildItemSetting(
                'assets/ic_rate.png',
                'Rate This App',
                null,
              ),
              Gap(20),
              buildItemSetting(
                'assets/ic_key.png',
                'Change Password',
                null,
              ),
              Gap(20),
              buildItemSetting(
                'assets/ic_interest.png',
                'Interest Personalized',
                null,
              ),
              Gap(20),
              buildItemSetting(
                'assets/ic_logout.png',
                'Logout',
                logout,
              ),
              Gap(20),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProfile() {
    return FutureBuilder(
      future: DSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Account account = Account.fomJson(Map.from(snapshot.data!));

        return Row(
          children: [
            Image.asset(
              "assets/profile.png",
              width: 50.0,
              height: 50.0,
            ),
            Gap(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF070623),
                  ),
                ),
                Gap(2),
                Text(
                  account.email,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF838384),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildItemSetting(
    String icon,
    String name,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 52,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
          border: Border.all(
            width: 1.0,
            color: Color.fromARGB(255, 25, 5, 172),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 24.0,
              height: 24.0,
            ),
            Gap(14),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Color(0XFF070623),
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/ic_arrow_next.png',
              width: 20.0,
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
