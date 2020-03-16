import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
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

final dateFormatter = DateFormat('yyyy-MM-dd hh:mm');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Entry"),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: new Text( 'Select picture below', style: new TextStyle( fontSize: 20.0)
              ),
            ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 10),
                        child: RaisedButton(
                        child: IconButton(
                            iconSize: 160.0,
                              icon: const Icon(Icons.camera_alt),
                              tooltip: 'Location',
                              onPressed: () {
                          Navigator.pushNamed(context, '/camera');
                          print('post pic bro');
                              }
                        ), onPressed: () {},
                    ),
                ),
              ),
                            Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 50),
                          child: Center(
                            child: TextFormField( 
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.teal)),
                                  hintText: 'Number of Items',
                                  ),
                              validator: (value) { 
                              if (value.isEmpty) {
                                return 'Please enter some text';
                                }
                                return null;
                                },
                                keyboardType: TextInputType.number,
          ),
                          ),
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
                  'name' :'new screen with min and secs',
                  'totalFood' :32214,
                  'submission_date': dateFormatter.format(DateTime.now()),
                  'photoURL': 'https://cdn.vox-cdn.com/thumbor/jRl_yTfNV6SBvi9lsb6I7uQ-Xo4=/0x0:3610x2456/1820x1213/filters:focal(1517x940:2093x1516):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/66460994/1204093920.jpg.0.jpg',
                  'locationData.latitude' : '29.7508',
                  'locationData.longitude' : '95.3621'
                }); 
                    }
              ), onPressed: () {},
            )
          ),
            ],
      ),
    );
  }
  }
