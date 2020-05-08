import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';

class BreakPauseModel extends ChangeNotifier {
  final planService = PlanService();
  Timer timer;

  int _breakPause;
  int _currentBreakPause;
  bool _isTimerActive = false;
  int _currentMilliseconds = 0;

  int get breakPause => _breakPause;
  int get currentBreakPause => _currentBreakPause;
  bool get isTimerActive => _isTimerActive;

  ///Initiates the plan. Without the initiation, the timer would not be able to work because breakPause and currentBreakPause is null
  ///The initiation requests a plan from firestore depending on the ID of the document which is the title of each plan.
  ///the breakPause and the currentBreakPause will be initiated based on the breakPause time in the document. Call every other method inside
  ///this class, when you are sure, that init() was called.
  init(PlanModel planModel) async{

    final DocumentSnapshot snapshot = await planService.getPlan(planModel.title);
    final plan = PlanModel.fromMap(snapshot.data);

    _breakPause = plan.breakPause;
    _currentBreakPause = _breakPause;
  }

  ///refreshes or resets the currentBreakPause to its default Value based on the preferred breakPause time the user has set
  ///specifically for a plan.
  _refresh(){
    _currentBreakPause = _breakPause;
    notifyListeners();
  }
  ///Starts the Timer which is responsible to decrease the currentBreakPause in seconds
  start(){
    timer = Timer.periodic(Duration(milliseconds: 100), (timer){
         _isTimerActive = true;
        _currentMilliseconds++;
        _decreaseTimer();
        _refreshWhenTimeExpired();
      });
  }
  ///Manual timer refresh, currently implemented when user hits breakPauseButton again while timer is running.
  ///The reason for having this possibility is when the user does not want to wait the breakPause he was setting before execution
  ///It is also called inside cancelExecutionButton to cancel the timer when canceling the execution by navigating back to main page
  stop(){
    if(timer != null){
      _cancelTimer();
      _refresh();
    }
    else{
      _cancelTimer();
    }
  }
  ///Resets the timer when the countdown hits zero
  _refreshWhenTimeExpired(){
    if(_currentBreakPause == 0){
      _cancelTimer();
      _refresh();
    }
  }
  ///Stops the timer from counting
  _cancelTimer(){
    if(timer != null){
      timer.cancel();
      _isTimerActive = false;
    }
  }
  ///Decrements the timer in 1 second steps. the milliseconds is based on the timerspeed, without the speed increase in milliseconds,
  ///it would cause a delay when refreshing the time, which was not acceptable at the moment
  _decreaseTimer(){
    if(_currentMilliseconds == 10){
      _decrease();
      _currentMilliseconds = 0;
      notifyListeners();
    }
  }
  ///Decreases the currentBreakPause in 1 second steps each time it is called. The currentBreakPause should not
  ///be able to go below zero
  _decrease(){
    if(_currentBreakPause > 0){
      _currentBreakPause--;
    }
    /*
    if(_currentBreakPause == 0){
      _currentBreakPause = 0;
    }

     */
  }
}