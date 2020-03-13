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
                  if (snapshot.hasData && snapshot.data.documents.length > 0) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                              var post = snapshot.data.documents[index];
                              return ListTile(
                                leading: Text(post['votes'].toString()),
                                title: Text('Post Title')
                                );
                            }
                          ),
                        ),
                        RaisedButton(
                          child: Text('Send data'),
                          onPressed: (){
                            Firestore.instance.collection('bandnames').add({
                            'votes' :222,
                            'submission_date': DateTime.parse('2020-01-31')
                          }); 
                          }
                        )
                      ]
                    );
                }
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
              )
          );
        }


}



