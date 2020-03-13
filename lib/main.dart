import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Band Name Survey',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const MyHomePage(title: 'Possible Band Names'),
          );
        }
      }
      
      class MyHomePage extends StatelessWidget {
        const MyHomePage({Key key, this.title}) : super(key: key);
        
        final String title;

        Widget _buildListItem(BuildContext context,  DocumentSnapshot document) {
          return ListTile(
            title: Row(children:[
              Expanded(
                child: Text(
                  document['name'],
                )
                ),
                Container(
                  child:Text(
                    document['votes'].toString(),
                  ))
                ],
                ),
                onTap: () {
                  print("Should increase votes here");
                },
            );
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              ),
              body: StreamBuilder(
                stream: Firestore.instance.collection('bandnames').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('....loading');
                  return ListView.builder(
                    itemExtent: 80.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
            );
                }
              )
          );
        }
}