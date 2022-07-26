import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:te/check_login.dart';
import 'package:te/home.dart';
import 'package:te/search_page.dart';
import 'package:te/user_login.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:te/mymap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var widget ;
  var value = await SharedPref.getLoginValue();
  if (value != null) {
    widget = MyApp(email: await SharedPref.getemailValue(), name: await SharedPref.getnameValue());
  } else {
    widget = LoginScreen();
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Search_for_user(),
    ),
  );
}

