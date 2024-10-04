// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/controller/booking_status_controller.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:flutter_motobike_app/widgets/button_secondary.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
  final bookingStatusController = Get.find<BookingStatusController>();
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();

  final isComplete = false.obs;

  tapPin(int number) {
    if (pin1.text == '') {
      pin1.text = number.toString();
      return;
    }
    if (pin2.text == '') {
      pin2.text = number.toString();
      return;
    }
    if (pin3.text == '') {
      pin3.text = number.toString();
      return;
    }
    if (pin4.text == '') {
      pin4.text = number.toString();
      isComplete.value = true;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputPIN(pin1),
                    Gap(24),
                    inputPIN(pin2),
                    Gap(24),
                    inputPIN(pin3),
                    Gap(24),
                    inputPIN(pin4),
                  ],
                ),
                Gap(50),
                buildNumberInput(),
              ],
            ),
          ),
          Gap(50),
          Obx(() {
            if (!isComplete.value)
              return SizedBox(); // Jika pin tidak terisi semua muncul sizebox kosong
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ButtonPrimary(
                text: 'Pay Now',
                onTap: () {
                  bookingStatusController.bike = {
                    'id': widget.bike.id,
                    'name': widget.bike.name,
                    'image': widget.bike.image,
                    'category': widget.bike.category,
                  };
                  Navigator.pushNamed(
                    context,
                    '/success-booking',
                    arguments: widget.bike,
                  );
                },
              ),
            );
          }),
          Gap(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ButtonSecondary(
              onTap: () => Navigator.pop(context),
              text: 'Cancel Payment',
            ),
          ),
          Gap(30),
        ],
      ),
    );
  }

  Widget buildNumberInput() {
    return SizedBox(
      width: 300,
      child: GridView.count(
        crossAxisCount: 3, // 3 column
        physics: NeverScrollableScrollPhysics(), // gabisa di scroll
        shrinkWrap: true, // physis mati sepaket dengan shrinkwrap
        padding: const EdgeInsets.all(0),
        children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((number) {
          return Center(
            child: IconButton(
              onPressed: () => tapPin(number),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.white,
                ),
              ),
              constraints: BoxConstraints(
                // ngatur bayangan ketika di klik
                maxHeight: 60,
                maxWidth: 60,
                minHeight: 60,
                minWidth: 60,
              ),
              icon: Text(
                '$number',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                  color: Color(0XFF070623),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget inputPIN(TextEditingController editingController) {
    InputBorder inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFF070623),
        width: 3,
      ),
    );

    return SizedBox(
      width: 30,
      child: TextField(
        controller: editingController,
        obscureText: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32.0,
          color: Color(0XFF070623),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          enabled: false, // Agar tidak muncul keyboard
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          border: inputBorder,
          disabledBorder: inputBorder,
        ),
      ),
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
              "Wallet Security",
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
              "assets/ic_more.png",
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
