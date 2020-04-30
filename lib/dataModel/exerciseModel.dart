import 'package:flutter/cupertino.dart';

class ExerciseModel extends ChangeNotifier{
  String title;
  int setQuantity;
  ExerciseModel({@required this.title, @required this.setQuantity});

  ExerciseModel.fromJson(Map snapshot) :
        title = snapshot['title'] ?? '',
        setQuantity = snapshot['tags'] ?? 0;
  Map<String, dynamic> toJson(){
    return {
      "title" : title,
      "setQuantity" : setQuantity,
    };
  }
}