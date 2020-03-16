import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';


class NewFoodWaste extends StatefulWidget {
  
  @override
  _NewFoodWasteState createState() => _NewFoodWasteState();
}

class _NewFoodWasteState extends State<NewFoodWaste> {

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

final dateFormatter = DateFormat('yyyy-MM-dd');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Entry"),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: new Text( 'Select picture below', style: new TextStyle( fontSize: 20.0)
              ),
            ),
              Padding(
                padding: EdgeInsets.only(top: 250),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 300),
                        child: RaisedButton(
                        child: IconButton(
                            iconSize: 100.0,
                              icon: const Icon(Icons.picture_in_picture),
                              tooltip: 'Location',
                              onPressed: () {
                          print('post pic bro');
                              }
                        ), onPressed: () {},
                    ),
                ),
              ),
                  Text('Save'),
                    Container(
            child: RaisedButton(
              child: IconButton(
                    icon: const Icon(Icons.cloud),
                    tooltip: 'Save',
                    onPressed: () {
                Navigator.pop(context);
                  Firestore.instance.collection('bandnames').add({
                  'name' :'new screen',
                  'totalFood' :667,
                  'submission_date': dateFormatter.format(DateTime.now())
                }); 
                print('save to firestore');
                    }
              ), onPressed: () {},
            )
          ),
            ],
      ),
    );
  }
  }
  

          //   RaisedButton(
          //   onPressed: () {
          //     Share.share('Hey! Meet me at ${locationData.latitude}, ${locationData.longitude}');
          //   },
          //   child: IconButton(
          //         icon: const Icon(Icons.cloud),
          //         tooltip: 'Location',
          //         onPressed: () {
          //     //Navigator.pop(context);
          //     //   Firestore.instance.collection('bandnames').add({
          //     //   'name' :'testing',
          //     //   'totalFood' :222,
          //     //   'submission_date': dateFormatter.format(DateTime.now())
          //     // }); 
          //     print('save to firestore');
          //         }
          //   )
          // ),