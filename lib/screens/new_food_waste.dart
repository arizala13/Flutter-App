import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';


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


  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return Center(child: CircularProgressIndicator());
    } else {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Entry"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [ Text('Latitude: ${locationData.latitude}', style: Theme.of(context).textTheme.display1),
          Text('Longitude: ${locationData.longitude}', style: Theme.of(context).textTheme.display1,),
          RaisedButton(
            onPressed: () {
              //Navigator.pop(context);
              Share.share('Hey! Meet me at ${locationData.latitude}, ${locationData.longitude}');
            },
            child: Text('Share!'),
          ),
          ],
          ),
      ),
    );
  }
  }
}