// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/pages/fragment/browse_fragment.dart';
import 'package:flutter_motobike_app/pages/fragment/order_fragment.dart';
import 'package:flutter_motobike_app/pages/fragment/settings_fragment.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final fragments = [
    BrowseFragment(),
    OrderFragment(),
    SettingsFragment(),
  ];

  final fragmentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:
          true, // agar kalau ngescroll konten nya masih terlihat dibalik bottom navbar
      body: Obx(
        () => fragments[fragmentIndex.value],
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 78,
          decoration: BoxDecoration(
            color: Color(0XFF070623),
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: Row(
            children: [
              buildItemNav(
                label: 'Browse',
                icon: 'assets/ic_browse.png',
                iconOn: 'assets/ic_browse_on.png',
                isActive: fragmentIndex.value == 0,
                onTap: () {
                  fragmentIndex.value = 0;
                },
              ),
              buildItemNav(
                label: 'Orders',
                icon: 'assets/ic_chats.png',
                iconOn: 'assets/ic_chats_on.png',
                isActive: fragmentIndex.value == 1,
                onTap: () {
                  fragmentIndex.value = 1;
                },
              ),
              buildItemCircle(),
              buildItemNav(
                label: 'Chats',
                icon: 'assets/ic_browse.png',
                iconOn: 'assets/ic_browse_on.png',
                hasDot: true,
                onTap: () {},
              ),
              buildItemNav(
                label: 'Settings',
                icon: 'assets/ic_settings.png',
                iconOn: 'assets/ic_settings_on.png',
                isActive: fragmentIndex.value == 2,
                onTap: () {
                  fragmentIndex.value = 2;
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildItemNav({
    required final String label,
    required String icon, // icon off
    required String iconOn,
    required VoidCallback onTap,
    bool isActive = false,
    bool hasDot = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          height: 46,
          child: Column(
            children: [
              Image.asset(
                isActive ? iconOn : icon,
                width: 24.0,
                height: 24.0,
              ),
              Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(isActive ? 0XFFFFBC1C : 0XFFFFFFFF),
                    ),
                  ),
                  if (hasDot)
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Color(0XFFFF2056),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemCircle() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0XFFFFBC1C),
      ),
      // Unsc agar tidak mengikuti icon lain untuk ukurannya, wilayah container
      child: UnconstrainedBox(
        child: Image.asset(
          "assets/ic_status.png",
          width: 24.0,
          height: 24.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
