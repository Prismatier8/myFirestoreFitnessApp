import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ExecutionData extends ChangeNotifier{

  Map<String,dynamic> setMap;
  String exerciseRef;
  String planRef;
  Timestamp date;

  ExecutionData({
    @required this.setMap,
    @required this.exerciseRef,
    @required this.planRef,
    @required this.date,
  });

  ExecutionData.fromJson(Map snapshot) :
        setMap = snapshot['setMap'] ?? {},
        exerciseRef = snapshot['exerciseRef'] ?? '',
        planRef = snapshot['planRef'] ?? '',
        date = snapshot['date'] ?? '';


   Map<String, dynamic> toJson() {
    return {
      "setMap" : setMap,
      "exerciseRef": exerciseRef,
      "planRef": planRef,
      "date" : date,
    };
  }
}

