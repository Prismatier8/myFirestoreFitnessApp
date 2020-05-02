import 'package:flutter/material.dart';

class PlanModel{
  String id;
  int breakPause = 60;
  String title;
  List<dynamic> tags;
  List<dynamic> exerciseRef;
  bool vibrationSignal;
  bool audioSignal;
  PlanModel({@required this.title,
    @required this.breakPause,
    @required this.tags,
    @required this.vibrationSignal,
    @required this.audioSignal,
    this.exerciseRef});


  PlanModel.fromMap(Map snapshot) :
      breakPause = snapshot['breakPause'] ?? '',
      title = snapshot['title'] ?? '',
      tags = snapshot['tags'] ?? [],
      exerciseRef = snapshot['exerciseRef'] ?? [],
      vibrationSignal = snapshot['vibrationSignal'] ?? false,
      audioSignal = snapshot['audioSignal'] ?? false;

  Map<String, dynamic> toJson(){
    return {
      'breakPause' : breakPause,
      'title' : title,
      'tags' : tags,
      'exerciseRef' : exerciseRef,
      'vibrationSignal' : vibrationSignal,
      'audioSignal' : audioSignal,
    };
  }
}