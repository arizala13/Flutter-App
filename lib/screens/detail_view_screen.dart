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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed view"),
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