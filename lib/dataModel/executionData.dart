import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ExecutionData extends ChangeNotifier{

  double weight;
  int repetition;
  String exerciseRef;
  String planRef;
  Timestamp date;

  ExecutionData({@required this.weight, @required this.repetition, @required this.exerciseRef, @required this.planRef});

  ExecutionData.fromJson(Map snapshot) :
        weight = snapshot['weight'] ?? 0.0,
        repetition = snapshot['repetition'] ?? 0,
        exerciseRef = snapshot['exerciseRef'] ?? '',
        planRef = snapshot['planRef'] ?? '',
        date = snapshot['date'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      "weight": weight,
      "repetition": repetition,
      "exerciseRef": exerciseRef,
      "planRef": planRef,
      "date": Timestamp.now(),
    };
  }
}