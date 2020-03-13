import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/character.dart';



class RemoteDataScreen extends StatefulWidget {

  static const URL = 'http://swapi.co/api/people/1/';

  @override
  _RemoteDataScreenState createState() => _RemoteDataScreenState();
}

class _RemoteDataScreenState extends State<RemoteDataScreen> {

  Future<http.Response> apiResponse = http.get(RemoteDataScreen.URL);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: apiResponse,
      builder:(context, snapshot) {
        Widget child;
        if(snapshot.hasData) {
          Character character = Character.fromJSON(jsonDecode(snapshot.data.body));
          child = Text('${character.name}', style: TextStyle(color: Colors.white));
        } else {
          child = CircularProgressIndicator();
        }

        return Center(child: child);
      }
    );

  }
}