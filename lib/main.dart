// ignore_for_file: prefer_const_constructors
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_motobike_app/firebase_options.dart';
import 'package:flutter_motobike_app/pages/booking_page.dart';
import 'package:flutter_motobike_app/pages/chatting_page.dart';
import 'package:flutter_motobike_app/pages/checkout_page.dart';
import 'package:flutter_motobike_app/pages/detail_page.dart';
import 'package:flutter_motobike_app/pages/discover_page.dart';
import 'package:flutter_motobike_app/pages/pin_page.dart';
import 'package:flutter_motobike_app/pages/signin_page.dart';
import 'package:flutter_motobike_app/pages/signup_page.dart';
import 'package:flutter_motobike_app/pages/splash_screen.dart';
import 'package:flutter_motobike_app/pages/success_booking_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/bike.dart';

Future<void> main() async {
  // Tipe firebase plugin jadi harus ditambah si WidgetsFluBin
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((value) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFFEFEFF0),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == null) return SplashScreen();
          return DiscoverPage();
        },
      ),
      routes: {
        '/discover': (context) => DiscoverPage(),
        '/signup': (context) => SignupPage(),
        '/signin': (context) => SigninPage(),
        '/detail': (context) {
          String bikeId = ModalRoute.of(context)!.settings.arguments as String;
          return DetailPage(bikeId: bikeId);
        },
        '/booking': (context) {
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return BookingPage(bike: bike);
        },
        '/checkout': (context) {
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          Bike bike = data['bike'];
          String startDate = data['startDate'];
          String endDate = data['endtDate'];
          return CheckoutPage(
            bike: bike,
            startDate: startDate,
            endDate: endDate,
          );
        },
        '/pin': (context) {
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return PinPage(bike: bike);
        },
        '/success-booking': (context) {
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return SuccessBookingPage(bike: bike);
        },
        '/chatting': (context) {
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          String uid = data['uid'];
          String userName = data['userName'];
          return ChattingPage(
            uid: uid,
            userName: userName,
          );
        },
      },
    );
  }
}
