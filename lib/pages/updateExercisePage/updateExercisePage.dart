import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/updateExercisePane.dart';


class UpdateExercisePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final ExerciseModel exerciseModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          exerciseModel.title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
          child: UpdateExercisePane(exercise: exerciseModel,)
      ),
    );
  }

}