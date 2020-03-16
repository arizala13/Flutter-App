import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';


class DetailViewScreen extends StatefulWidget {
  
  @override
  _DetailViewScreenState createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {

LocationData locationData;

@override
void initState() {
  super.initState();
  retrieveLocation();
}

void retrieveLocation() async {
  var locationService = Location();
  locationData = await locationService.getLocation();
  setState( () {} );
}

final dateFormatter = DateFormat('yyyy-MM-dd hh:mm');


  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Detailed view"),
  //     ),
  //     body: Column(
  //       children: [
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: new Text( 'Food picture', style: new TextStyle( fontSize: 20.0)
  //             ),
  //           ),
  //           Image.network(
  //         'https://cdn.vox-cdn.com/thumbor/jRl_yTfNV6SBvi9lsb6I7uQ-Xo4=/0x0:3610x2456/1820x1213/filters:focal(1517x940:2093x1516):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/66460994/1204093920.jpg.0.jpg',
  //       ),
  //                           Padding(
  //               padding: EdgeInsets.only(top: 100),
  //               child: Center(
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   padding: EdgeInsets.only(bottom: 50),
  //                         child: Center(
  //                           child: TextFormField( 
  //                             textAlign: TextAlign.center,
  //                             decoration: new InputDecoration(
  //                               border: new OutlineInputBorder(
  //                                 borderSide: new BorderSide(color: Colors.teal)),
  //                                 )
  //         ),
  //                         ),
  //                 ),
  //               ),
  //             ),
  //             Text('Location of post', style: Theme.of(context).textTheme.display1),
  //             Text('Latitude: ${locationData.latitude}', style: Theme.of(context).textTheme.display1),
  //         Text('Longitude: ${locationData.longitude}', style: Theme.of(context).textTheme.display1,),
  //           ],
  //     ),
  //   );
  // }


// Testing adding the firestore database 
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed view"),
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
                            Text(post['submission_date'].toString()),
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
                                  Text('Latitude: ${locationData.latitude}'),
                                  Text('Longitude: ${locationData.longitude}'),
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
