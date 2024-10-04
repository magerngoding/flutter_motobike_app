// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/models/account.dart';
import 'package:flutter_motobike_app/widgets/button_primary.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../models/bike.dart';

class CheckoutPage extends StatefulWidget {
  final Bike bike;
  final String startDate;
  final String endDate;

  const CheckoutPage({
    Key? key,
    required this.bike,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  num balance = 20000000;
  double grandTotal = 10000000;

  // inialisasi
  FToast fToast = FToast();

  checkoutNow() {
    if (balance < grandTotal) {
      Widget notifUI = Transform.translate(
        offset: Offset(0, -50),
        child: Container(
          height: 96,
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Color(0XFFFF2055),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0XFFFF2055).withOpacity(0.25),
                blurRadius: 20,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: Text(
            "Failed to checkout. Your wallet has no enough balance at this moment",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      );
      // Cara menampilkan pop up nya
      fToast.showToast(
        child: notifUI,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(milliseconds: 2500),
      );
      return;
    }

    Navigator.pushNamed(context, '/pin', arguments: widget.bike);
  }

  @override
  void initState() {
    fToast.init(context);
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
          Gap(24),
          buildSnippetBike(),
          Gap(24),
          buildDetails(),
          Gap(24),
          buildPaymentMethod(),
          Gap(30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              onTap: () => checkoutNow(),
              text: 'Checkout Now',
            ),
          ),
          Gap(30),
        ],
      ),
    );
  }

  Widget buildPaymentMethod() {
    final payments = [
      ['My Wallets', 'assets/wallet.png'],
      ['Credit Card', 'assets/cards.png'],
      ['Cash', 'assets/cash.png'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Payment Method",
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
            itemCount: payments.length,
            itemBuilder: (context, index) {
              return Container(
                width: 130,
                margin: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == payments.length - 1 ? 24 : 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  border: index == 0 // jika index ke 1 ada border biru nya
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
                      payments[index][1],
                      width: 38.0,
                      height: 38.0,
                    ),
                    Gap(10),
                    Text(
                      payments[index][0],
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
        ),
        Gap(24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FutureBuilder(
            future: DSession.getUser(),
            builder: (context, snapshoot) {
              if (snapshoot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              Account account = Account.fomJson(
                Map.from(snapshoot.data!),
              );
              return Stack(
                children: [
                  Image.asset(
                    "assets/bg_wallet.png",
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          account.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "02/30",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 0,
                    top: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Gap(6),
                        Text(
                          NumberFormat.currency(
                            decimalDigits: 0,
                            locale: 'en_US',
                            symbol: '\$',
                          ).format(balance),
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          buildItemDetail1('Price', '\$50.000', '/day'),
          Gap(14),
          buildItemDetail2('Start Date', widget.startDate),
          Gap(14),
          buildItemDetail2('End Date', widget.endDate),
          Gap(14),
          buildItemDetail1('Duration', '15', '/day'),
          Gap(14),
          buildItemDetail2('Sub Total Price', '\$250,999'),
          Gap(14),
          buildItemDetail2('Insurance 20%', '\$14,394'),
          Gap(14),
          buildItemDetail2('Tax 20%', '\$3, 490'),
          Gap(14),
          buildItemDetail3(
            'Grand Total',
            NumberFormat.currency(
              decimalDigits: 0,
              locale: 'en_US',
              symbol: '\$',
            ).format(grandTotal),
          )
        ],
      ),
    );
  }

  Widget buildItemDetail1(
    String title,
    String data,
    String unit,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF838384),
          ),
        ),
        Spacer(),
        Text(
          data,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(0XFF070623),
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(0XFF070623),
          ),
        ),
      ],
    );
  }

  Widget buildItemDetail2(
    String title,
    String data,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF838384),
          ),
        ),
        Spacer(),
        Text(
          data,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(0XFF070623),
          ),
        ),
      ],
    );
  }

  Widget buildItemDetail3(
    String title,
    String data,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF838384),
          ),
        ),
        Spacer(),
        Text(
          data,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(0XFF4A1DFF),
          ),
        ),
      ],
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
              "Checkout",
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
