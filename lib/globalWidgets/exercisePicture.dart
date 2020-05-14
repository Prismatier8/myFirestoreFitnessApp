import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';

class ExercisePicture extends StatelessWidget {
  final ExerciseModel exercise;

  ExercisePicture(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.black12,
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Icon(Icons.photo_camera, color: Colors.black38,),
        ),
      ),
    );
  }
}
