import 'package:contactbook/contactscreen.dart';
import 'package:contactbook/database.dart';
import 'package:contactbook/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';

class InsertContact extends StatefulWidget {
  const InsertContact({Key? key}) : super(key: key);

  @override
  State<InsertContact> createState() => _InsertContactState();
}

class _InsertContactState extends State<InsertContact> {
  TextEditingController insertNameController = TextEditingController();
  TextEditingController insertNumberController = TextEditingController();
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
                "Insert Contact.",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: totalHeight * 0.1,
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
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: bodyHeight * 0.42,
                          width: totalWidth,
                          child: Lottie.asset(
                              "lottieanimation/133564-typing.json")),
                      TextField(
                        controller: insertNameController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF4B68D1), width: 2)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF4B68D1), width: 2)),
                          hintText: "Enter Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF4B68D1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                insertNameController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Color(0xFF4B68D1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.03,
                      ),
                      TextField(
                        controller: insertNumberController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF4B68D1), width: 2)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF4B68D1), width: 2)),
                          hintText: "Enter Number",
                          prefixIcon: Icon(
                            Icons.call,
                            color: Color(0xFF4B68D1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                insertNumberController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Color(0xFF4B68D1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          String insertName = insertNameController.text;
                          String insertNumber = insertNumberController.text;
                          MyDataBase()
                              .insertContact(insertName, insertNumber,
                              SplashScreen.prefs!.getInt("UserID") ?? 0, db!)
                              .then((value) {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) {
                                return ContactScreen();
                              },
                            ));
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
                            "Insert",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Scaffold(
// body: Container(
// padding: EdgeInsets.all(8),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// TextField(
// controller: insertNameController,
// decoration: InputDecoration(
// border: OutlineInputBorder(), hintText: "Name"),
// ),
// SizedBox(
// height: 10,
// ),
// TextField(
// controller: insertNumberController,
// decoration: InputDecoration(
// border: OutlineInputBorder(), hintText: "Number"),
// ),
// ElevatedButton(
// onPressed: () {
// String insertName = insertNameController.text;
// String insertNumber = insertNumberController.text;
// MyDataBase()
//     .insertContact(insertName, insertNumber,
// SplashScreen.prefs!.getInt("UserID") ?? 0, db!)
//     .then((value) {
// Navigator.pushReplacement(context, MaterialPageRoute(
// builder: (context) {
// return ContactScreen();
// },
// ));
// });
// },
// child: Text("insert"))
// ],
// ),
// ),
// )
