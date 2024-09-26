// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/controller/booking_status_controller.dart';
import 'package:flutter_motobike_app/controller/browse_featured_controller.dart';
import 'package:flutter_motobike_app/controller/browse_news_controller.dart';
import 'package:flutter_motobike_app/widgets/failed_ui.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/bike.dart';

class BrowseFragment extends StatefulWidget {
  const BrowseFragment({super.key});

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  // inisialisasi
  final browseFeaturedController = Get.put(BrowseFeaturedController());
  final browseNewsController = Get.put(BrowseNewsController());
  final bookingStatusController = Get.put(BookingStatusController());

  // trigerred
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      browseFeaturedController.fetchFeatured();
      browseNewsController.fetchNewst();
      // bookingStatusController.bike = {
      //   'name': 'Enfielding Pro',
      //   'image': 'https://images2.alphacoders.com/249/24912.jpg',
      // };
    });
    super.initState();
  }

  // clear data controller biar ga ketumpuk2
  @override
  void dispose() {
    Get.delete<BrowseFeaturedController>(force: true);
    Get.delete<BrowseNewsController>(force: true);
    Get.delete<BookingStatusController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(30 + MediaQuery.of(context).padding.top),
          buildHeader(),
          buildBookingStatus(),
          Gap(30),
          buildCategories(),
          Gap(30),
          buildFeatured(),
          Gap(30),
          buildNews(),
          Gap(110),
        ],
      ),
    );
  }

  Widget buildBookingStatus() {
    return Obx(
      () {
        Map bike = bookingStatusController.bike;
        if (bike.isEmpty) return SizedBox();
        return Container(
          height: 96,
          margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          decoration: BoxDecoration(
            color: Color(0XFF4A1DFF),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0XFF4A1DFF).withOpacity(0.25),
                blurRadius: 20,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: Stack(
            // biar gambar yang digeser kepotong pake STACK
            children: [
              Positioned(
                left: -20, // mundurin paksa
                top: 0,
                bottom: 0,
                child: ExtendedImage.network(
                  bike['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Your Booking ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: bike['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              color: Color(0XFFFFBC1C),
                            ),
                          ),
                          TextSpan(
                            text: '\nhas been delivered to.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'News Bikes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff070623),
            ),
          ),
        ),
        Obx(() {
          String status = browseNewsController.status;
          if (status == '') return const SizedBox();
          if (status == 'loading') {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (status != 'success') {
            return Center(child: FailedUI(message: status));
          }
          List<Bike> list = browseNewsController.list;
          return ListView.builder(
            // Akan bentrok jika 2 listview.builder untuk efek scroll nya. Jadi yang ini dimatikan / tidak menggunakan efek scroll
            physics: NeverScrollableScrollPhysics(),
            // 1 paket dengan shrinkwrap
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: list.length,
            itemBuilder: (context, index) {
              Bike bike = list[index];
              final margin = EdgeInsets.only(
                top: index == 0 ? 10 : 9,
                bottom: index == list.length - 1 ? 20 : 9,
              );
              return buildItemNews(bike, margin);
            },
          );
        }),
      ],
    );
  }

  Widget buildItemNews(Bike bike, EdgeInsetsGeometry margin) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          // argument cek kirim ada atau tidak pada routes  main.dart
          arguments: bike.id,
        );
      },
      child: Container(
        height: 98,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Row(
          children: [
            ExtendedImage.network(
              bike.image,
              width: 90,
              height: 70,
              fit: BoxFit
                  .contain, // menggunakan ini(boxfit.cover) jika ukuran gamabr beda2 / kalau sama menggunakan .contain
            ),
            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bike.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF070623),
                    ),
                  ),
                  Gap(4),
                  Text(
                    bike.category,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF838384),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end, // biar /day kebawah
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'es_US',
                    symbol: '\$',
                  ).format(bike.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF6747E9),
                  ),
                ),
                Text(
                  '/day',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF838384),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatured() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Featured',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff070623),
            ),
          ),
        ),
        const Gap(10),
        Obx(() {
          String status = browseFeaturedController.status;
          if (status == '') return const SizedBox();
          if (status == 'loading') {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (status != 'success') {
            return Center(child: FailedUI(message: status));
          }
          List<Bike> list = browseFeaturedController.list;
          return SizedBox(
            height: 295,
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Bike bike = list[index];
                final margin = EdgeInsets.only(
                  left: index == 0 ? 24 : 12,
                  right: index == list.length - 1 ? 24 : 12,
                );
                bool isTrending = index == 0;
                return buildItemFeatured(bike, margin, isTrending);
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildItemFeatured(
    Bike bike,
    EdgeInsetsGeometry margin,
    bool isTrending,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detail',
          // argument cek kirim ada atau tidak pada routes  main.dart
          arguments: bike.id,
        );
      },
      child: Container(
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        width: 252,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ExtendedImage.network(
                  bike.image,
                  width: 220,
                  height: 171,
                ),
                if (isTrending)
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFF2055),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XFFFF2056).withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    child: Text(
                      "TRENDING",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Spacer(), // Tidak aktif jika tidak diset tinggi nya
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bike.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF070623),
                        ),
                      ),
                      Gap(4),
                      Text(
                        bike.category,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF838384),
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Color(0XFFFFBC1C),
                  ),
                  itemSize: 16,
                  unratedColor: Colors.grey[300],
                  initialRating: bike.rating.toDouble(),
                  itemPadding: EdgeInsets.all(0),
                  allowHalfRating: true,
                  ignoreGestures: true,
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end, // biar /day kebawah
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'es_US',
                    symbol: '\$',
                  ).format(bike.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF6747E9),
                  ),
                ),
                Text(
                  '/day',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF838384),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategories() {
    final categories = [
      ['City', 'assets/ic_city.png'],
      ['Downhill', 'assets/ic_downhill.png'],
      ['Beach', 'assets/ic_beach.png'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0XFF070623),
            ),
          ),
        ),
        Gap(10),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: categories.map((e) {
                return Container(
                  margin: const EdgeInsets.only(right: 14),
                  padding: const EdgeInsets.fromLTRB(16, 14, 30, 14),
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        e[1],
                        width: 24.0,
                        height: 24.0,
                      ),
                      Gap(10),
                      Text(
                        e[0],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF070623),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/logo_text.png",
            height: 38,
            fit: BoxFit.fitHeight,
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/ic_notification.png",
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
