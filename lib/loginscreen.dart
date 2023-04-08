import 'package:contactbook/contactscreen.dart';
import 'package:contactbook/database.dart';
import 'package:contactbook/registerscreen.dart';
import 'package:contactbook/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:sqflite/sqlite_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyDataBase().getDataBase().then((value) {
      db = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusBarHeight;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: totalHeight,
              width: totalWidth,
              color: Color(0xFF4B68D1),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 12),
              child: Text(
                "Log in.",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: totalHeight * 0.10,
              child: Container(
                height: totalHeight * 0.9,
                width: totalWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: bodyHeight * 0.42,
                      width: totalWidth,
                      // color: Colors.yellow,
                      child: Lottie.asset(
                        "lottieanimation/121421-login.json",
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(
                                    0xFF4B68D1,
                                  ),
                                  width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            controller: loginNameController,
                            decoration: InputDecoration(
                              hintText: "Enter your username",
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF4B68D1),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.close,
                                  color: Color(0xFF4B68D1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: bodyHeight * 0.03,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(
                                    0xFF4B68D1,
                                  ),
                                  width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            controller: loginPasswordController,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.password,
                                color: Color(0xFF4B68D1),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.close,
                                  color: Color(0xFF4B68D1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            String loginName = loginNameController.text;
                            String loginPassword =
                                loginPasswordController.text;
                            MyDataBase().select(loginName, loginPassword, db!).then((value) {
                              bool isogin = value.length == 1;
                              setState(() {
                                if (isogin) {
                                  print("====${value[0]["ID"]}");
                                  print("====value $value");
                                  SplashScreen.prefs!.setInt("UserID", value[0]["ID"]);
                                  SplashScreen.prefs!.setBool("islogin", true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Login Sucessfully"),
                                    ),
                                  );
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return ContactScreen();
                                    },
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("User not found")));
                                }
                              });
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: bodyHeight * 0.08,
                            width: totalWidth,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFF4B68D1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: bodyHeight * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account ?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterScreen();
                                  },
                                ));
                              },
                              child: Text("Sign in"),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
