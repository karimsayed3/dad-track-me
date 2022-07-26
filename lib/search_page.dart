import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:te/mymap.dart';

class Search_for_user extends StatefulWidget {
  const Search_for_user({Key? key}) : super(key: key);

  @override
  State<Search_for_user> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Search_for_user> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
        child: Column(
          children: [
            StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('location')
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              print(snapshot.data!.docs[index].id);
                              if (snapshot.data!.docs[index].id == 'abokhadiga6@gmail.com'){
                                return ListTile(
                                title: Text(
                                    snapshot.data!.docs[index]['name'].toString()),
                                subtitle: Row(
                                  children: [
                                    Text(snapshot.data!.docs[index]['latitude']
                                        .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(snapshot.data!.docs[index]['longitude']
                                        .toString()),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyMap(snapshot.data!.docs[index].id),
                                      ),
                                    );
                                  },
                                ),
                              );
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                              
                            });
                      },
                    ),
          ],
        ),
      );
  }
}