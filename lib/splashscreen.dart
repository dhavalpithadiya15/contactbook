import 'package:contactbook/contactscreen.dart';
import 'package:contactbook/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static SharedPreferences? prefs;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forSplashScreen();
  }

  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset("lottieanimation/Loader.json"),
      ),
    );
  }

  Future<void> forSplashScreen() async {
    SplashScreen.prefs = await SharedPreferences.getInstance();
    login = SplashScreen.prefs!.getBool("islogin") ?? false;

    Future.delayed(Duration(seconds: 5)).then((value) {
      if (login) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ContactScreen();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ));
      }
    });
  }
}
