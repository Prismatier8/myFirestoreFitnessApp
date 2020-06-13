import 'dart:async';
import 'dart:isolate';
import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';


///Isolated timer
void runTimer(SendPort sendPort) {
  Timer.periodic(Duration(milliseconds: 100), (timer) {
    sendPort.send("");
  });
}

class BreakPauseModel extends ChangeNotifier {
  final planService = PlanService();
  Timer timer;
  PlanModel _plan;
  int _breakPause;
  int _currentBreakPause;
  bool _isTimerActive = false;
  int _currentMilliseconds = 0;

  int get breakPause => _breakPause;
  int get currentBreakPause => _currentBreakPause;
  bool get isTimerActive => _isTimerActive;
  Isolate isolate;

  ///Initiates the plan. Without the initiation, the timer would not be able to work because breakPause and currentBreakPause is null
  ///The initiation requests a plan from firestore depending on the ID of the document which is the title of each plan.
  ///the breakPause and the currentBreakPause will be initiated based on the breakPause time in the document. Call every other method inside
  ///this class, when you are sure, that init() is called before.
  init(PlanModel planModel) async {
    final DocumentSnapshot snapshot =
        await planService.getPlan(planModel.title);
    final planData = PlanModel.fromMap(snapshot.data);
    _plan = planData;
    _breakPause = planData.breakPause;
    _currentBreakPause = _breakPause;
  }
  ///refreshes or resets the currentBreakPause to its default value based on the preferred breakPause time the user has set
  ///specifically for a plan.
  _refresh() {
    _currentBreakPause = _breakPause;
    notifyListeners();
  }


  //TODO: The Timer is not working when smartphone is sleeping. You need to access system background service (AlarmManager, WorkManager??)
  //TODO: But then the Timer has to be an isolated Top-Level function in Dart which I was not able to call a method inside a class that
  //TODO: has a state. If you have enough time, then try to understand Androids WorkManager and especially the package workmanager.
  //TODO: Also learn more about the get_it package, this might help for the solution. There has to be an easy way. Same problem in the executionTimerModel
  ///Starts the Timer which is responsible to decrease the currentBreakPause in seconds. The Timer is isolated in a new thread to ensure
  ///functionality in the background. Otherwise the timer would pause when user navigates to a new Application or disables phone display
  ///the listen() is called every time the isolate sends a message
  start() async {
    if(_isTimerActive == false){
      _isTimerActive = true;

      ReceivePort receivePort = ReceivePort();
      isolate = await Isolate.spawn(runTimer, receivePort.sendPort);

      receivePort.listen((message) {
        _currentMilliseconds++;
        _decreaseTimer();
        _refreshWhenTimeExpired();
      });
    }
  }

  ///manual timer refresh, call when execution process is over
  stop() {
      _cancelTimer();
      _refresh();
  }

  ///Resets the timer when the countdown hits zero and plays Sound and/or let phone vibrate.
  _refreshWhenTimeExpired() async{
    if (_isEndTimeReached()) {
      _cancelTimer();
      _refresh();
      if (_plan.audioSignal == true) {
        await _playSound();

      }
      /*
      if (_plan.vibrationSignal == true) {
        await _vibrate();
      }

       */
    }
  }
  ///plays sound from assets
  _playSound() async {
    final cache = AudioCache();
    await cache.play("impact.wav");
  }
  /*
  ///vibrate phone
  _vibrate() async {
    final int vibrationLength = 2000;
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(duration: vibrationLength);
    }
  }

   */
  ///Stops the timer from counting by killing the isolate
  _cancelTimer() {
    if (isolate != null) {
      isolate.kill(priority: Isolate.immediate);
      isolate = null;
    }
    _isTimerActive = false;
  }

  ///Decrements the timer in 1 second steps. the milliseconds is based on the timerspeed, without the speed increase in milliseconds,
  ///it would cause a delay when refreshing the time, which was not acceptable at the moment
  _decreaseTimer() {
    if (_currentMilliseconds == 10) {
      _decrease();
      _currentMilliseconds = 0;
      notifyListeners();
    }
  }
  ///simple check if timer has reached the end of the breakpause. Called when user is not manually resetting timer.
  bool _isEndTimeReached() {
    if (_currentBreakPause == 0) {
      return true;
    } else {
      return false;
    }
  }

  ///Decreases the currentBreakPause in 1 second steps each time it is called. The currentBreakPause should not
  ///be able to go below zero
  _decrease() {
    if (_currentBreakPause > 0) {
      _currentBreakPause--;
    }
  }
}
