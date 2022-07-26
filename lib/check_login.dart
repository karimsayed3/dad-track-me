import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:te/home.dart';

class SharedPref {
  static setLoginValue({state, email, name}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("login", state);
    preferences.setString("email", email);
    preferences.setString("name", name);
    // ignore: avoid_print
    print(preferences.getString('login'));
    print(preferences.getString('email'));
    print(preferences.getString('name'));

  }

  static getLoginValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.getString('login');
    print(value);
    return value;
  }

  static getemailValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.getString('email');
    return value;
    }

    static getnameValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.getString('name');
    return value;
    }// ignore: unrelated_type_equality_checks
  }
