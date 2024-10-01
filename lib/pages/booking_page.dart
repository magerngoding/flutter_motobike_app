// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:flutter_motobike_app/widgets/input.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../models/bike.dart';

class BookingPage extends StatefulWidget {
  final Bike bike;

  const BookingPage({
    Key? key,
    required this.bike,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final edtName = TextEditingController();
  final edtStarDate = TextEditingController();
  final edtEndDate = TextEditingController();

  pickDate(TextEditingController editingController) {
    showDatePicker(
            // showdatepicker untuk pop up calendar
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 30)),
            initialDate: DateTime.now() // inisial pas dibuka tanggal sekarang
            )
        .then(
      (pickDate) {
        if (pickDate == null) return;

        editingController.text = DateFormat('dd MMM yyy').format(pickDate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Gap(24),
          buildSnippetBike(),
          Gap(24),
          buildInput(),
          Gap(24),
          buildAgency(),
          Gap(24),
          buildInsurance(),
          Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              onTap: () {
                Navigator.pushNamed(context, '/checkout', arguments: {
                  'bike': widget.bike,
                  'startDate': edtStarDate.text,
                  'endtDate': edtEndDate.text,
                });
              },
              text: 'Proceed to Checkout',
            ),
          ),
          Gap(36),
        ],
      ),
    );
  }

  Widget buildInsurance() {
    final listAgency = ['Revolte', 'KBP City', 'Sumedap'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Insurance",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
          Gap(12),
          SizedBox(
            height: 52,
            child: DropdownButtonFormField(
              icon: Image.asset(
                "assets/ic_arrow_down.png",
                width: 20.0,
                height: 20.0,
              ),
              value: 'Set available insurance',
              items: [
                'Set available insurance',
                'Jiwa perkara, Kejiwaan',
                'Kejiwaan',
                'Stuck',
              ].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF070623),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(right: 16),
                prefixIcon: UnconstrainedBox(
                  // UnconstrainedBox biar tidak terpengaruh dari ukuran parents
                  alignment: Alignment(0.2, 0), // untuk geser icon
                  child: Image.asset(
                    "assets/ic_insurance.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color(0XFF4A1DFF),
                    width: 2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAgency() {
    final listAgency = ['Revolte', 'KBP City', 'Sumedap'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Agency",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
        ),
        Gap(12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listAgency.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == listAgency.length - 1 ? 24 : 8,
                ),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  border: index == 1 // jika index ke 1 ada border biru nya
                      ? Border.all(
                          color: Color(0XFF4A1DFF),
                          width: 3,
                        )
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/agency.png",
                      width: 38.0,
                      height: 38.0,
                    ),
                    Gap(10),
                    Text(
                      listAgency[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF070623),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete Name",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_profile.png',
            hint: 'Write your real name',
            editingController: edtName,
          ),
          Gap(16),
          Text(
            "Start Rent Date",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_calendar.png',
            hint: 'Choose your date',
            editingController: edtStarDate,
            enable: false,
            onTapBox: () => pickDate(edtStarDate),
          ),
          Gap(16),
          Text(
            "End",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(12),
          Input(
            icon: 'assets/ic_calendar.png',
            hint: 'Choose your date',
            editingController: edtEndDate,
            enable: false,
            onTapBox: () => pickDate(edtEndDate),
          ),
          Gap(16),
        ],
      ),
    );
  }

  Widget buildSnippetBike() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      height: 98,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            widget.bike.image,
            width: 90,
            height: 70,
            fit: BoxFit.contain,
          ),
          Gap(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bike.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF070623),
                  ),
                ),
                Text(
                  widget.bike.category,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF070623),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${widget.bike.rating}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF070623),
                ),
              ),
              Gap(4),
              const Icon(
                Icons.star,
                size: 20.0,
                color: Color(0XFFFFBC1C),
              ),
            ],
          ),
        ],
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
              "Booking",
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
