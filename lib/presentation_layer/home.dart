// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:te/presentation_layer/mymap.dart';
import 'package:te/presentation_layer/search_page.dart';

class MyApp extends StatefulWidget {
  final email;
  final name;

  const MyApp({super.key, this.email, this.name});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _getLocation(widget.email,widget.name);
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xffF5591F),
        title: const Text('live location tracker'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search_for_user(),
                    ));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                _getLocation(widget.email, widget.name);
              },
              child: const Text('add my location',style: const TextStyle(color: Color(0xffF5591F)),),
            ),
            TextButton(
              onPressed: () {
                _listenLocation(widget.email, widget.name);
              },
              child: const Text('enable live location',style: TextStyle(color: const Color(0xffF5591F)),),
            ),
            TextButton(
              onPressed: () {
                _stopListening();
              },
              child: const Text('stop live location',style: TextStyle(color: const Color(0xffF5591F))),
            ),
            Expanded(
                child: MyMap(widget.email)),
          ],
        ),
      ),
    );
  }

  _getLocation(email, name) async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc(email).set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': name,
        'email': email
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation(email, name) async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc(email).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': name,
        'email': email
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
