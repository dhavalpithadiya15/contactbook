import 'dart:io';

import 'package:contactbook/database.dart';
import 'package:contactbook/insertcontactscreen.dart';
import 'package:contactbook/splashscreen.dart';
import 'package:contactbook/updateusercontact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Database? db;
  bool isSearch = false;
  List<Map> userContactList = [];
  List<Map> searchContactList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forViewUserContact();
  }

  void forViewUserContact() {
    MyDataBase().getDataBase().then((value) {
      db = value;
      MyDataBase().viewContact(SplashScreen.prefs!.getInt("UserID"), db!)
          .then((value) {
        setState(() {
          userContactList = value;
        });
        print("===usercontactlist $userContactList");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
        appBar: isSearch
            ? AppBar(
                backgroundColor: Colors.white,
                title: TextField(
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        if (value.isNotEmpty) {
                          searchContactList = [];
                          for (int i = 0; i < userContactList.length; i++) {
                            String name = userContactList[i]["Name"];
                            if (name.contains(value)) {
                              searchContactList.add(userContactList[i]);
                              print(searchContactList);
                            }
                          }
                        } else {
                          searchContactList = userContactList;
                        }
                      });
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isSearch = false;
                                searchContactList = userContactList;
                              });
                            },
                            icon: Icon(Icons.close)))),
              )
            : AppBar(backgroundColor: Color(0xFF4B68D1),title: Text("Contact"), actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = true;
                      });
                    },
                    icon: Icon(Icons.search))
              ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF4B68D1),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return InsertContact();
                },
              ));
            },
            child: Icon(Icons.add)),
        body: ListView.builder(
          itemCount:
              isSearch ? searchContactList.length : userContactList.length,
          itemBuilder: (context, index) {
            Map mm =
                isSearch ? searchContactList[index] : userContactList[index];
            return ListTile(
              leading: Text("${index + 1}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
              title: Text("${mm['Name']}",style: TextStyle(fontSize: 18)),
              subtitle: Text("${mm['Number']}",style: TextStyle(fontSize: 18)),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return UpdateUserContact(userContactList[index]);
                      },
                    ));
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        MyDataBase()
                            .delteContact(userContactList[index]['ID'], db!)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Deleted Sucessfully")));
                          setState(() {
                            forViewUserContact();
                          });
                        });
                      },
                      child: Text("Delete"),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text("Update"),
                    )
                  ];
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> onBack() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you want to Exit ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  exit(0);
                },
                child: Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"))
          ],
        );
      },
    );
    return Future.value();
  }
}
