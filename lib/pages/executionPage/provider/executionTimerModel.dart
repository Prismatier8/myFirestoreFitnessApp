import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';

///top level timer that is isolated when called to ensure background functionality
void runTimer(SendPort sendPort) {
  Timer.periodic(Duration(seconds: 1), (timer) {
    sendPort.send("");
  });
}
class ExecutionTimerModel extends ChangeNotifier{

  int _currentSeconds = 0;
  int _currentMinute = 0;
  Isolate isolate;

  ///Initiates timer in an isolated thread. notifies all Consumer when receivePort receives
  ///message
  Future init() async{
    ReceivePort receivePort = ReceivePort();
    isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
    receivePort.listen((message){
      _currentSeconds++;
      notifyListeners();
    });
  }
  ///kill isolate and set state to default
  kill(){
    if(isolate != null){
      isolate.kill(priority: Isolate.immediate);
      isolate = null;
    }
    _currentMinute = 0;
    _currentSeconds = 0;
  }
  ///Transforms seconds in Minute count. if training completed before a minute,
  ///add a minute, so that the minute counter in the trainingPage is at least showing
  ///one minute instead of zero. Caused by .round()
  int getTime() {
    double minutes = _currentSeconds / 60;
    int temporary = minutes.round();
    if(temporary != 0){
      _currentMinute = minutes.round();
    } else {
      _currentMinute = 1;
    }
    return minutes.round();
  }
  ///Save full execution time to plan document
  saveTimeToDB(PlanService planService, PlanModel plan){
    planService.updatePlan(plan.title, {"planDuration" : _currentMinute});
  }
}