import 'package:flutter/material.dart';

class PlanModel{
  String id;
  int breakPause = 60;
  String title;
  List<dynamic> tags;

  PlanModel({@required this.title, @required this.breakPause, @required this.tags});


  PlanModel.fromMap(Map snapshot) :
      breakPause = snapshot['breakPause'] ?? '',
      title = snapshot['title'] ?? '',
      tags = snapshot['tags'] ?? [];

  Map<String, dynamic> toJson(){
    return {
      'breakPause' : breakPause,
      'title' : title,
      'tags' : tags,
    };
  }
}