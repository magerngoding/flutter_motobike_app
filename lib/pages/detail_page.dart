// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/common/info.dart';
import 'package:flutter_motobike_app/controller/detail_controller.dart';
import 'package:flutter_motobike_app/models/account.dart';
import 'package:flutter_motobike_app/models/bike.dart';
import 'package:flutter_motobike_app/models/chat.dart';
import 'package:flutter_motobike_app/sources/chat_source.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:flutter_motobike_app/widgets/failed_ui.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final String bikeId;

  const DetailPage({
    Key? key,
    required this.bikeId,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailController = Get.put(DetailController());

  late final Account account;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      detailController.fetchBike(widget.bikeId);
    });
    DSession.getUser().then((value) {
      account = Account.fomJson(Map.from(value!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(30),
          Obx(() {
            String status = detailController.status;
            if (status == '') return SizedBox();
            if (status == 'loading') {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (status != 'success') {
              return Padding(
                padding: EdgeInsets.all(24.0),
                child: FailedUI(message: status),
              );
            }
            Bike bike = detailController.bike;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      bike.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF070623),
                      ),
                    ),
                  ),
                  const Gap(10),
                  buildStats(bike),
                  Gap(30),
                  Stack(
                    alignment: Alignment
                        .bottomCenter, // biar lingkaran nya ke bawah motor
                    children: [
                      Image.asset(
                        "assets/ellipse.png",
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: ExtendedImage.network(
                          bike.image,
                          height: 250,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                  Gap(30),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF070623),
                    ),
                  ),
                  Gap(10),
                  Text(
                    bike.about,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF070623),
                    ),
                  ),
                  Gap(40),
                  buildPrice(bike),
                  Gap(16),
                  buildSendMessage(bike),
                  Gap(30),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildSendMessage(Bike bike) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xffFFFFFF),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          String uid = account.uid;
          Chat chat = Chat(
            roomId: uid,
            message: 'Ready?',
            receiverId: 'cs',
            senderId: uid,
            bikeDetail: {
              'image': bike.image,
              'name': bike.name,
              'category': bike.category,
              'id': bike.id,
            },
          );

          Info.netral('Loading...');
          ChatSource.openChatRoom(uid, account.name).then(
            (value) {
              ChatSource.send(chat, uid).then(
                (value) {
                  Navigator.pushNamed(context, '/chatting', arguments: {
                    'uid': uid,
                    'username': account.name,
                  });
                },
              );
            },
          );
        },
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/ic_message.png",
                width: 24.0,
                height: 24.0,
              ),
              Gap(10),
              Text(
                'Send Message',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff070623),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPrice(Bike bike) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      height: 88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Color(0XFF070623),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // biar /day kebawah
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
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '/day',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 132,
            child: ButtonPrimary(
              onTap: () {
                Navigator.pushNamed(context, '/booking', arguments: bike);
              },
              text: 'Book Now!',
            ),
          ),
        ],
      ),
    );
  }

  // Kirim data diparameter
  Widget buildStats(Bike bike) {
    final stats = [
      ['assets/ic_beach.png', bike.level],
      [],
      ['assets/ic_downhill.png', bike.category],
      [],
      ['assets/ic_star.png', '${bike.rating}/5'],
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stats.map((e) {
        if (e.isEmpty) return Gap(20);
        return Row(
          children: [
            Image.asset(e[0], width: 24.0, height: 24.0),
            Gap(4),
            Text(
              e[1],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0XFF070623),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onDoubleTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/ic_arrow_back.png",
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Detail",
              textAlign: TextAlign.center, // Pake ini karna di wrap Expanded
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFF070623),
              ),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/ic_favorite.png",
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
