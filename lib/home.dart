// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:te/check_login.dart';
import 'dart:async';

import 'package:te/mymap.dart';
import 'package:te/search_page.dart';

class MyApp extends StatefulWidget {
  final email;
  final name;

  const MyApp({super.key, this.email, this.name});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  late GoogleMapController _controller;
  bool _added = false;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF5591F),
        title: Text('live location tracker'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search_for_user(),
                    ));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                _getLocation(widget.email, widget.name);
              },
              child: Text('add my location',style: TextStyle(color: Color(0xffF5591F)),),
            ),
            TextButton(
              onPressed: () {
                _listenLocation(widget.email, widget.name);
              },
              child: Text('enable live location',style: TextStyle(color: Color(0xffF5591F)),),
            ),
            TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('stop live location',style: TextStyle(color: Color(0xffF5591F))),
            ),
            Expanded(
                // child: StreamBuilder(
                //   stream: FirebaseFirestore.instance
                //       .collection('location')
                //       .snapshots(),
                //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (!snapshot.hasData) {
                //       return Center(child: CircularProgressIndicator());
                //     }
                //     return ListView.builder(
                //         itemCount: snapshot.data?.docs.length,
                //         itemBuilder: (context, index) {
                //           print(snapshot.data!.docs[index].id);
                //           if (snapshot.data!.docs[index].id ==
                //               'abokhadiga6@gmail.com') {
                //             //   return ListTile(
                //             //   title: Text(
                //             //       snapshot.data!.docs[index]['name'].toString()),
                //             //   subtitle: Row(
                //             //     children: [
                //             //       Text(snapshot.data!.docs[index]['latitude']
                //             //           .toString()),
                //             //       SizedBox(
                //             //         width: 20,
                //             //       ),
                //             //       Text(snapshot.data!.docs[index]['longitude']
                //             //           .toString()),
                //             //     ],
                //             //   ),
                //             //   trailing: IconButton(
                //             //     icon: Icon(Icons.directions),
                //             //     onPressed: () {
                //             //       Navigator.of(context).push(
                //             //         MaterialPageRoute(
                //             //           builder: (context) =>
                //             //               MyMap(snapshot.data!.docs[index].id),
                //             //         ),
                //             //       );
                //             //     },
                //             //   ),
                //             // );

                //             // return MyMap(snapshot.data!.docs[index].id);
                //             return GoogleMap(
                //               mapType: MapType.hybrid,
                //               markers: {
                //                 Marker(
                //                   position: LatLng(
                //                     snapshot.data!.docs.singleWhere((element) =>
                //                         element.id ==
                //                         snapshot
                //                             .data!.docs[index].id)['latitude'],
                //                     snapshot.data!.docs.singleWhere((element) =>
                //                         element.id ==
                //                         snapshot
                //                             .data!.docs[index].id)['longitude'],
                //                   ),
                //                   markerId: MarkerId('id'),
                //                   icon: BitmapDescriptor.defaultMarkerWithHue(
                //                     BitmapDescriptor.hueMagenta,
                //                   ),
                //                 ),
                //               },
                //               initialCameraPosition: CameraPosition(
                //                   target: LatLng(
                //                     snapshot.data!.docs.singleWhere((element) =>
                //                         element.id ==
                //                         snapshot
                //                             .data!.docs[index].id)['latitude'],
                //                     snapshot.data!.docs.singleWhere((element) =>
                //                         element.id ==
                //                         snapshot
                //                             .data!.docs[index].id)['longitude'],
                //                   ),
                //                   zoom: 22.0),
                //               onMapCreated:
                //                   (GoogleMapController controller) async {
                //                 setState(() {
                //                   _controller = controller;
                //                   _added = true;
                //                 });
                //               },
                //             );
                //           } else {
                //             return CircularProgressIndicator();
                //           }
                //         });
                //   },
                // ),
                child: MyMap(widget.email)),
          ],
        ),
      ),
    );
  }

  _getLocation(email, name) async {
    try {
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
