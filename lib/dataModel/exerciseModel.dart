import 'package:flutter/cupertino.dart';

class ExerciseModel extends ChangeNotifier{
  String title;
  int setQuantity;
  List<dynamic> setReferences;

  ExerciseModel({@required this.title, @required this.setQuantity, @required this.setReferences});

  ExerciseModel.fromJson(Map snapshot) :
        title = snapshot['title'] ?? '',
        setQuantity = snapshot['tags'] ?? 0,
        setReferences = snapshot['setReferences'] ?? [];
  Map<String, dynamic> toJson(){
    return {
      "title" : title,
      "setQuantity" : setQuantity,
      "setReferences" : setReferences,
    };
  }
}