import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/detail_view_screen.dart';
import 'screens/new_food_waste.dart';
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
          '/': (context) => MyHomePage(),
          '/new': (context) => NewFoodWaste(),
          '/location': (context) => ShareLocation(),
          '/remote': (context) => RemoteDataScreen(),
          '/detail': (context) => DetailViewScreen(),
          },
          theme: ThemeData(primaryColor: Colors.red),
            );
          }
        }
    
class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Wastegram')),
              ),
              body: StreamBuilder(
                stream: Firestore.instance.collection('bandnames').orderBy('submission_date', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.documents.length > 0) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                              var post = snapshot.data.documents[index];
                          return GestureDetector(
                                                      child: ListTile(
                                  trailing: Text(post['totalFood'].toString()),
                                  title: Center(child: 
                                  Text((post['submission_date'].toString())))
                                  ),
                                  onTap: (){
                            Navigator.pushNamed(context, '/detail');
                          }
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