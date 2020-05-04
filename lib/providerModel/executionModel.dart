import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/setService.dart';

class ExecutionModel extends ChangeNotifier {
  final SetService _setService = SetService();
  List<String> exerciseRef = [];
  int _currentRef = 0;
  int _currentSet = 0;
  int _maxRefLength = 0;
  int _maxSetLength = 0;

  init(PlanModel plan) async{
    exerciseRef = plan.exerciseRef;
    _maxRefLength = plan.exerciseRef.length;

  }

  next() {}
}
