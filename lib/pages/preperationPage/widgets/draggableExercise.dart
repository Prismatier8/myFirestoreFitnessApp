import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/exerciseImage.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'package:myfitnessmotivation/globalWidgets/updateExerciseNavigator.dart';

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
    final cardWith = MediaQuery.of(context).size.width * 0.95;
    return Container(
      width: cardWith,
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
            ExerciseImage(
              exercise: widget.exerciseModel,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: TitleDisplay(

                title: widget.exerciseModel.title,
                containerWidth: cardWith - 160,
                containerHeight: 20,
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
