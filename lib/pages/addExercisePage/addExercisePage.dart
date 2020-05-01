import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/addExercisePage/widgets/addExercisePane.dart';

class AddExercisePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final ExerciseModel exerciseModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exerciseModel.title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: AddExercisePane(),
    );
  }

}