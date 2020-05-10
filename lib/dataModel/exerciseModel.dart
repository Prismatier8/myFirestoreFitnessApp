import 'package:flutter/cupertino.dart';

class ExerciseModel extends ChangeNotifier{
  String title;
  int setQuantity;
  List<dynamic> setReferences;
  List<dynamic> muscleGroupReferences;
  List<dynamic> planReferences;

  ExerciseModel({@required this.title, @required this.setQuantity, @required this.setReferences, this.muscleGroupReferences});

  ExerciseModel.fromJson(Map snapshot) :
        title = snapshot['title'] ?? '',
        setQuantity = snapshot['tags'] ?? 0,
        setReferences = snapshot['setReferences'] ?? [],
        muscleGroupReferences = snapshot['muscleGroupReferences'] ?? [],
        planReferences = snapshot['planReferences'] ?? [];
  Map<String, dynamic> toJson(){
    return {
      "title" : title,
      "setQuantity" : setQuantity,
      "setReferences" : setReferences,
      "muscleGroupReferences" : muscleGroupReferences,
      "planReferences" : planReferences,
    };
  }
}