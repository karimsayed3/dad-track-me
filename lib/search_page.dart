// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:te/mymap.dart';
import 'package:te/widgets/widgets.dart';

class Search_for_user extends StatefulWidget {
  Search_for_user({Key? key}) : super(key: key);

  @override
  State<Search_for_user> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Search_for_user> {
  TextEditingController searchController = TextEditingController();
  List<String> userList = [];
  String? searchItem;


  // }
  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color(0xffF5591F),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: const Color(0xffF5591F),
                            ),
                            hintText: "Enter Email",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          searchItem = searchController.text;
                        });
                        // _create();
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('location')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          height: 5,
                          width: 5,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        // print(snapshot.data!.docs[index].id);
                        if (snapshot.data!.docs[index].id == searchItem) {
                          userList.add(searchItem.toString());

                          print(userList);
                          return UserInfo(snapshot, index);
                        } else {
                          return const SizedBox(
                            height: 20.0,
                            width: 20.0,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UserInfo(snapshot, index) {
    return ListTile(
      title: Text(snapshot.data!.docs[index]['name'].toString()),
      subtitle: Row(
        children: [
          Text(snapshot.data!.docs[index]['latitude'].toString()),
          const SizedBox(
            width: 20,
          ),
          Text(snapshot.data!.docs[index]['longitude'].toString()),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.directions),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyMap(snapshot.data!.docs[index].id),
            ),
          );
        },
      ),
    );
  }
}
