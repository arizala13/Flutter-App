import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/camera_screen.dart';
import 'screens/share_location_screen.dart';
import 'screens/remote_data_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Band Name Survey',
          routes: {
      '/location': (context) => ShareLocation(),
      '/camera': (context) => CameraScreen(),
      '/remote': (context) => RemoteDataScreen(),
      },
      theme: ThemeData(primaryColor: Colors.blue),
      home: const MyHomePage(title: 'Band names'),
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
                              actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Location',
            onPressed: () {
              Navigator.pushNamed(context, '/location');
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            tooltip: 'Camera',
            onPressed: () {
              Navigator.pushNamed(context, '/camera');
            },
          ),
          IconButton(
            icon: const Icon(Icons.airline_seat_recline_normal),
            tooltip: 'Remote',
            onPressed: () {
              Navigator.pushNamed(context, '/remote');
            },
          ),
                              ]
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



