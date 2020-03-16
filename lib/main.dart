import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/camera_screen.dart';
import 'screens/new_food_waste.dart';
import 'screens/share_location_screen.dart';
import 'screens/remote_data_screen.dart';
import 'package:intl/intl.dart';

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
          '/new': (context) => NewFoodWaste(),
          '/location': (context) => ShareLocation(),
          '/camera': (context) => CameraScreen(),
          '/remote': (context) => RemoteDataScreen(),
          },
          theme: ThemeData(primaryColor: Colors.red),
          home:  MyHomePage(title: 'Wasteagram'),
            );
          }
        }
      
      class MyHomePage extends StatelessWidget {
        MyHomePage({Key key, this.title}) : super(key: key);
        
        final String title;

        final dateFormatter = DateFormat('yyyy-MM-dd');

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text(title)),
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
                                trailing: Text(post['totalFood'].toString()),
                                title: Center(child: Text((post['submission_date'].toString())))
                                );
                            }
                          ),
                        ),
                        FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: (){
                            Navigator.pushNamed(context, '/new');
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



