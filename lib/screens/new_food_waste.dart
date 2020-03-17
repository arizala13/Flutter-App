import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart' as Path;


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

  File image;

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child(Path.basename(image.path));
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    print(url);
    print('in get image');
    saveToDatabase(url);
  }

    void saveToDatabase(url) {
    
    Firestore.instance.collection('bandnames').add({
                  'totalFood' :6969,
                  'submission_date': dateFormatter.format(DateTime.now()),
                  'photoURL': url,
                  'latitude' : 29.7508,
                 'longitude' : 95.3621
                }); 

      print('in saveToDatabase');
  }


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
                                getImage();
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
                  //'totalFood' :32214,
                  // 'submission_date': dateFormatter.format(DateTime.now()),
                   // 'photoURL': saveToDatabase();
                  // 'latitude' : 29.7508,
                  // 'longitude' : 95.3621
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
