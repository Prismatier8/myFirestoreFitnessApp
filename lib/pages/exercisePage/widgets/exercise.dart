import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/updateExerciseNavigator.dart';
import 'package:myfitnessmotivation/pages/exercisePage/widgets/deleteExerciseDialog.dart';

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
          child: InkWell(
            onLongPress: (){
              _showDeleteExerciseDialog(context);
            },
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
      ),
    );
  }
  void _showDeleteExerciseDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DeleteExerciseDialog(exerciseModel);
        });
  }
}
