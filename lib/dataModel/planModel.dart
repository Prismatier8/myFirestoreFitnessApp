import 'package:flutter/material.dart';

class Plan{
  String id;
  int breakPause = 60;
  String title;
  List<String> tags;

  Plan({@required this.title, @required this.breakPause, @required this.tags});


  Plan.fromMap(Map snapshot, String id) :
      id = id ?? '',
      breakPause = snapshot['price'] ?? '',
      title = snapshot['title'] ?? '',
      tags = snapshot['tags'] ?? [];

  toJson(){
    return {
      "breakPause" : breakPause,
      "title" : title,
      "tags" : tags,
    };
  }
}