import 'package:contactbook/database.dart';
import 'package:contactbook/loginscreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Database? db;

  bool nameCheck = false;
  bool emailCheck = false;
  bool numberCheck = false;
  bool passwordCheck = false;
  FocusNode fieldOne = FocusNode();
  FocusNode fieldFour = FocusNode();
  FocusNode fieldtwo = FocusNode();
  FocusNode fieldThree = FocusNode();
  String nameValid = "";
  String emailValid = "";
  String numberValid = "";
  String passwordValid = "";

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
                "Register here.",
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
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: bodyHeight * 0.40,
                          width: totalWidth,
                          child: Lottie.asset(
                            "lottieanimation/38435-register.json",
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.only(right: 15, left: 15),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  focusNode: fieldOne,
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        nameCheck = true;
                                        nameValid = "Please fill empty field";
                                      } else if (!RegExp('[a-zA-z]')
                                          .hasMatch(value)) {
                                        nameCheck = true;
                                        nameValid = "Please enter correct name";
                                      } else {
                                        nameCheck = false;
                                        FocusScope.of(context)
                                            .requestFocus(fieldtwo);
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      nameCheck = true;
                                      nameValid = "Please fill empty field";
                                      return nameValid;
                                    } else if (!RegExp('[a-zA-Z]')
                                        .hasMatch(value)) {
                                      nameCheck = true;
                                      nameValid = "Please enter correct name";
                                      return nameValid;
                                    } else {
                                      nameCheck = false;
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "eg: Dhaval",
                                      label: Text("Enter your name"),
                                      errorText: nameCheck ? nameValid : null),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  focusNode: fieldtwo,
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: [AutofillHints.email],
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        emailCheck = true;
                                        emailValid = "Please fill empty field";
                                      } else if (!EmailValidator.validate(
                                          value)) {
                                        emailCheck = true;
                                        emailValid =
                                            "Please enter correct name";
                                      } else {
                                        emailCheck = false;
                                        FocusScope.of(context)
                                            .requestFocus(fieldThree);
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      emailCheck = true;
                                      emailValid = "Please fill empty field";
                                      return emailValid;
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      emailCheck = true;
                                      emailValid = "Please enter correct name";
                                      return emailValid;
                                    } else {
                                      emailCheck = false;
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "eg: xyz@gamil.com",
                                    label: Text("Enter your email"),
                                    errorText: emailCheck ? emailValid : null,
                                  ),
                                ),
                                TextFormField(
                                  controller: numberController,
                                  focusNode: fieldThree,
                                  keyboardType: TextInputType.phone,
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        numberCheck = true;
                                        numberValid = "Please fill empty field";
                                      } else if (!RegExp(
                                              r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(value)) {
                                        numberCheck = true;
                                        numberValid =
                                            "Please enter correct number";
                                      } else {
                                        numberCheck = false;
                                        FocusScope.of(context)
                                            .requestFocus(fieldFour);
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      numberCheck = true;
                                      numberValid = "Please fill empty field";
                                      return numberValid;
                                    } else if (!RegExp(
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                        .hasMatch(value)) {
                                      numberCheck = true;
                                      numberValid =
                                          "Please enter correct number";
                                      return numberValid;
                                    } else {
                                      numberCheck = false;
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "eg: 7778905748",
                                      label: Text("Enter your phone number"),
                                      errorText:
                                          numberCheck ? numberValid : null),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  focusNode: fieldFour,
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        passwordCheck = true;
                                        passwordValid =
                                            "Please fill empty field";
                                      } else {
                                        passwordCheck = false;
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      passwordCheck = true;
                                      passwordValid = "Please fill empty field";
                                      return passwordValid;
                                    } else if (value.length <= 8) {
                                      passwordCheck = true;
                                      passwordValid =
                                          "minimum 8 character required";
                                      return passwordValid;
                                    } else {
                                      passwordCheck = false;
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "eg: *********",
                                      label: Text("Enter your password"),
                                      errorText:
                                          passwordCheck ? passwordValid : null),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      String name = nameController.text;
                                      String email = emailController.text;
                                      String number = numberController.text;
                                      String password = passwordController.text;
                                      MyDataBase().insertUser(name, email, number, password, db!);
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) {
                                          return LoginScreen();
                                        },
                                      ));
                                    } else {
                                      print("no");
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: bodyHeight * 0.06,
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ElevatedButton(
// onPressed: () {
// String name = nameController.text;
// String email = emailController.text;
// String number = numberController.text;
// String password = passwordController.text;
// print("${name},${email},${number},${password}");
// MyDataBase().insertUser(name, email, number, password, db!);
// Navigator.pushReplacement(context, MaterialPageRoute(
// builder: (context) {
// return LoginScreen();
// },
// ));
// },
// child: Text("Register")),


//*********************
