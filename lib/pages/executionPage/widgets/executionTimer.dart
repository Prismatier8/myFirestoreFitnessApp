import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:provider/provider.dart';

class ExecutionTimer extends StatefulWidget {
  final PlanModel plan;
  ExecutionTimer(this.plan);
  @override
  _ExecutionTimerState createState() => _ExecutionTimerState();
}

class _ExecutionTimerState extends State<ExecutionTimer> {
  int _currentSeconds = 0;
  int _currentMinute = 0;
  @override
  void initState() {

    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t){
      if(!mounted){
        return;
      }
      setState(() {
        _addMinutesToDB(context);
        _currentSeconds++;

      });
    });
  }
  ///Add full execution time when user finished plan training
  ///to the specific plan document
  _addMinutesToDB(BuildContext context){
    final executionModel = Provider.of<ExecutionModel>(context, listen: false);
    final planService = Provider.of<PlanService>(context, listen: false);
    if(executionModel.isFinished){
      planService.updatePlan(widget.plan.title, {"planDuration" : _currentMinute});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.access_time,
            size: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              _getMinute(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
  ///Transforms seconds in Minute count. if training completed before a minute,
  ///add a minute, so that the minute counter in the trainingPage is atleast showing
  ///one minute instead of zero. Caused by .round()
  String _getMinute() {
    double minutes = _currentSeconds / 60;
    int temporary = minutes.round();
    if(temporary != 0){
      _currentMinute = minutes.round();
    } else {
      _currentMinute = 1;
    }
    return minutes.round().toString() + " Min";
  }

}
