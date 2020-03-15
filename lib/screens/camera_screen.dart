import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class CameraScreen extends StatefulWidget {

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File image;

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storageReference = 
      FirebaseStorage.instance.ref().child(Path.basename(image.path));
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Center(
        child: RaisedButton(
          child:Text('Select Photo BRO!'),
          onPressed: () {
            getImage();
          },)
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image),
            SizedBox(height: 40),
            Semantics(
              label: 'Post a picture',
              child: RaisedButton(
                child: Text('Post it!'),
                onPressed: () {
                  
                },
              ),
            )
          ]
        )
      );
    }
  }
}