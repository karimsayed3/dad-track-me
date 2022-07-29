import 'dart:io';

import 'package:flutter/material.dart';
import 'package:te/SharedPref/check_login.dart';
import 'package:te/presentation_layer/home.dart';
import 'package:te/presentation_layer/widgets/widgets.dart';
// import 'package:login_ui_design/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
            color: new Color(0xffF5591F),
            gradient: LinearGradient(
              colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Image.asset(
                  "assets/images/app_logo.png",
                  height: 90,
                  width: 90,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, top: 20),
                alignment: Alignment.bottomRight,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          )),
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              textForm(
                controller: emailController,
                errorMessage: 'Please Enter Email Addresses',
                hintText: "Enter Email",
              ),
              textForm(
                controller: nameController,
                errorMessage: 'Please Enter Your Name',
                hintText: "Enter Your Name",
              ),

              GestureDetector(
                onTap: () {
                  if(formKey.currentState!.validate()){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(
                          email: emailController.text,
                          name: nameController.text,
                        ),
                      ),
                    );
                    
                    SharedPref.setLoginValue(
                    email: emailController.text,
                    name: nameController.text,
                    state: 'karim sayed ibrahim',
                  );
                  }
                  
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
