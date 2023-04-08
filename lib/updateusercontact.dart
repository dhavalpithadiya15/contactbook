import 'package:contactbook/contactscreen.dart';
import 'package:contactbook/database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqlite_api.dart';

class UpdateUserContact extends StatefulWidget {
  Map<dynamic, dynamic> userContactList;

  UpdateUserContact(this.userContactList);

  @override
  State<UpdateUserContact> createState() => _UpdateUserContactState();
}

class _UpdateUserContactState extends State<UpdateUserContact> {
  TextEditingController updateUserName = TextEditingController();
  TextEditingController updateUserNumber = TextEditingController();
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUserName.text = widget.userContactList["Name"];
    updateUserNumber.text = widget.userContactList["Number"];
    forDataBase();
  }

  void forDataBase() {
    MyDataBase().getDataBase().then((value) {
      setState(() {
        db = value;
      });
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
                "Update Contact.",
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
                              "lottieanimation/79172-update.json")),
                      SizedBox(
                        height: bodyHeight * 0.01,
                      ),
                      TextField(
                        controller: updateUserName,
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
                                updateUserName.clear();
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
                        controller: updateUserNumber,
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
                                updateUserNumber.clear();
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
                          MyDataBase()
                              .updateUserContact(db!, updateUserName.text, updateUserNumber.text, widget.userContactList["ID"]).then((value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
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
                            "Update",
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
// controller: updateUserName,
// decoration: InputDecoration(
// border: OutlineInputBorder(), hintText: "Name"),
// ),
// SizedBox(
// height: 10,
// ),
// TextField(
// controller: updateUserNumber,
// decoration: InputDecoration(
// border: OutlineInputBorder(), hintText: "Number"),
// ),
// ElevatedButton(
// onPressed: () {
// MyDataBase()
//     .updateUserContact(db!, updateUserName.text,
// updateUserNumber.text, widget.userContactList["ID"])
//     .then((value) {
// Navigator.pushReplacement(context, MaterialPageRoute(
// builder: (context) {
// return ContactScreen();
// },
// ));
// });
// },
// child: Text("Update"))
// ],
// ),
// ),
// );
