import 'package:flutter/material.dart';

class MuscleGroupModel extends ChangeNotifier{
  String title;

  MuscleGroupModel({@required this.title});

  MuscleGroupModel.fromMap(Map snapshot) :
      title = snapshot['title'] ?? '';

  Map<String, dynamic> toJson(){
    return {
      'title' : title,
    };
  }
}