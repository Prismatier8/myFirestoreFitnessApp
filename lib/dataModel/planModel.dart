import 'package:flutter/material.dart';

class PlanModel{
  String id;
  int breakPause = 60;
  String title;
  List<dynamic> tags;
  List<dynamic> exerciseRef;
  bool vibrationSignal;
  bool audioSignal;
  int planDuration;
  PlanModel({@required this.title,
    @required this.breakPause,
    @required this.tags,
    @required this.vibrationSignal,
    @required this.audioSignal,
    this.exerciseRef});


  PlanModel.fromMap(Map snapshot) :
      breakPause = snapshot['breakPause'] ?? 0,
      title = snapshot['title'] ?? '',
      tags = snapshot['tags'] ?? [],
      exerciseRef = snapshot['exerciseRef'] ?? [],
      vibrationSignal = snapshot['vibrationSignal'] ?? false,
      audioSignal = snapshot['audioSignal'] ?? false,
      planDuration = snapshot['planDuration'] ?? 0;

  Map<String, dynamic> toJson(){
    return {
      'breakPause' : breakPause,
      'title' : title,
      'tags' : tags,
      'exerciseRef' : exerciseRef,
      'vibrationSignal' : vibrationSignal,
      'audioSignal' : audioSignal,
      'planDuration' : planDuration,
    };
  }
}