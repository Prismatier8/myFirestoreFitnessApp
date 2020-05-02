import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/updateExerciseNavigator.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';

class Exercise extends StatelessWidget {
  final ExerciseModel exerciseModel;
  Exercise(this.exerciseModel);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(exerciseModel.title,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Spacer(),
              UpdateExerciseNavigator(exerciseModel),
            ],
          ),
        ),
      ),
    );
  }
}
