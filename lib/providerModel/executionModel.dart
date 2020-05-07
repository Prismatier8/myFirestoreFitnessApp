import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/setService.dart';

class ExecutionModel extends ChangeNotifier {
  final SetService _setService = SetService();
  List<dynamic> _exerciseRef = [];

  List<SetModel> _currentSetList = [];
  SetModel _currentSet;
  String _currentExerciseName;
  int _currentRefIndex = 0;
  int _currentSetIndex = 0;

  int _maxRefLength = 0;
  int _maxSetLength = 0;

  SetModel getCurrentSet(){
    return _currentSet;
  }
  get currentExerciseName => _currentExerciseName;
  get currentSetList => _currentSetList;
  get maxSetLength => _maxSetLength;
  String getCurrentSetIndex(){
   return (_currentSetIndex + 1).toString();
  }
  init(PlanModel plan) async{
    _currentExerciseName = plan.exerciseRef[0];
    _exerciseRef = plan.exerciseRef;
    _maxRefLength = plan.exerciseRef.length;
    _transform();
  }
  _transform() async {
    final QuerySnapshot snapshot = await _setService.getReferencedSetsOrderedBySequence(_exerciseRef[_currentRefIndex]);
    SetModel set;

    for(int i = 0; i<snapshot.documents.length; i++){
      set = SetModel.fromMap(snapshot.documents[i].data);
      _currentSetList.add(set);
    }
    _currentSet = _currentSetList[_currentSetIndex];
    _maxSetLength = _currentSetList.length;
    notifyListeners();
  }
  next() {
    if(_currentSetIndex < _maxSetLength){

    }
  }
  _nextExercise(){

  }
  ///Call this method to clear its state to default values
  clear(){
    _currentSet = null;
    _exerciseRef = [];
    _currentSetList = [];
    _currentRefIndex = 0;
    _currentSetIndex = 0;
    _maxRefLength = 0;
    _maxSetLength = 0;
  }

  _isExecutionComplete(){

  }
}
