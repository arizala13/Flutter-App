import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DetailViewScreen extends StatefulWidget {
  
  @override
  _DetailViewScreenState createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal"),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
                stream: Firestore.instance.collection('bandnames').snapshots(),
                builder: (context, snapshot) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                              var post = snapshot.data.documents[index];
                          return Column(
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(post['submission_date'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.network(post['photoURL']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Number of items'),
                                  Text(post['totalFood'].toString()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Location of post'),
                                  Text(post['latitude'].toString()),
                                   Text(post['longitude'].toString())
                                ],
                              ),
                            ),
                            ]
                          );
                            }
                          ),
                        ),
                      ]
                    );
                }
              ),
    );
  }

  }
