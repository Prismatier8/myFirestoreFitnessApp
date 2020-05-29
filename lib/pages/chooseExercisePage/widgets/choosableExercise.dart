import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/exerciseImage.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/provider/selectionModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:provider/provider.dart';

class ChoosableExercise extends StatefulWidget {
  final PlanModel planModel;
  final ExerciseModel exerciseData;
  ChoosableExercise({@required this.planModel, @required this.exerciseData});
  @override
  _ChoosableExerciseState createState() => _ChoosableExerciseState();
}

class _ChoosableExerciseState extends State<ChoosableExercise> {
  bool _currentCheckBoxValue;
  @override
  void initState() {
    super.initState();
    _currentCheckBoxValue = _checkForExistingValue();
  }
  @override
  void didUpdateWidget(ChoosableExercise oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentCheckBoxValue = _checkForExistingValue();
  }
  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Container(
      width: cardWidth,
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: (){
            setState(() {
              _currentCheckBoxValue = !_currentCheckBoxValue;
              _updatePlan(_currentCheckBoxValue);
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ExerciseImage(
                exercise: widget.exerciseData,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: TitleDisplay(
                  title: widget.exerciseData.title,
                  containerWidth: cardWidth - 90,
                  containerHeight: 20,
                ),
              ),
              Spacer(),
              Checkbox(
                value: _currentCheckBoxValue,
                onChanged: (value){
                  setState(() {
                    _currentCheckBoxValue = value;
                    _updatePlan(_currentCheckBoxValue);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool _checkForExistingValue() {
    for (int i = 0; i < widget.planModel.exerciseRef.length; i++) {
      if (widget.planModel.exerciseRef[i]
          == widget.exerciseData.title) {
        return true;
      }
    }
    return false;
  }
  _updatePlan(bool value) {
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    final planService = Provider.of<PlanService>(context, listen: false);
    List<String> exercise = [widget.exerciseData.title];

    if(value == true){
      Map<String, dynamic> map = {"exerciseRef" : FieldValue.arrayUnion(exercise)};
      exerciseService.addPlanToExercise(widget.exerciseData.title, widget.planModel.title);
      planService.updatePlan(widget.planModel.title, map);
    } else {
      Map<String, dynamic> map = {"exerciseRef" : FieldValue.arrayRemove(exercise)};
      exerciseService.deletePlanFromExercise(widget.exerciseData.title, widget.planModel.title);
      planService.updatePlan(widget.planModel.title, map);
    }

  }
}
