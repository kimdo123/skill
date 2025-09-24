import 'package:flutter/material.dart';
import 'package:myhealthdata/screen/s_home_navi.dart';
import 'package:myhealthdata/screen/s_sign_in.dart';
import 'package:myhealthdata/screen/s_profile.dart';
import 'package:myhealthdata/screen/s_sign_up.dart';
import 'package:myhealthdata/screen/s_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      // home: AlarmFragment(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => SplashScreen(),
        '/signIn': (context) => LoginScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/profile': (context) => ProfileScreen(),
        '/home' : (context) => HomeScreenNavigation(),
      },
    );
  }
}
