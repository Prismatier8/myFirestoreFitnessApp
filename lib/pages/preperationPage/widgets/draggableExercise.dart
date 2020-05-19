import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/updateExerciseNavigator.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';

class DraggableExercise extends StatefulWidget {
  final ExerciseModel exerciseModel;
  final Key key;
  DraggableExercise(this.exerciseModel, this.key);
  @override
  _DraggableExerciseState createState() => _DraggableExerciseState();
}
class _DraggableExerciseState extends State<DraggableExercise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      child: Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.drag_handle
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget.exerciseModel.title,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Spacer(),
            UpdateExerciseNavigator(widget.exerciseModel),
          ],

        ),
      ),
    );
  }
}
