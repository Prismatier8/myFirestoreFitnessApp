import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/setService.dart';

class ExecutionModel extends ChangeNotifier {
  final SetService _setService = SetService();
  List<dynamic> _exerciseRef = [];
  bool _isFinished = false;
  bool _isLastExerciseSet = false;
  List<SetModel> _currentSetList = [];
  SetModel _currentSet;
  String _currentExerciseName;
  int _currentRefIndex = 0;
  int _currentSetIndex = 0;

  int _maxSetLength = 0;

  SetModel getCurrentSet(){
    return _currentSet;
  }
  get isLastExerciseSet => _isLastExerciseSet;
  get isFinished => _isFinished;
  get currentExerciseName => _currentExerciseName;
  get currentSetList => _currentSetList;
  get maxSetLength => _maxSetLength;
  String getCurrentSetIndex(){
   return (_currentSetIndex + 1).toString();
  }

  init(PlanModel plan) async{
    _currentExerciseName = plan.exerciseRef[0];
    _exerciseRef = plan.exerciseRef;
    await _transform();
  }
  _transform() async {
    final QuerySnapshot snapshot = await _setService.getReferencedSetsOrderedBySequence(_exerciseRef[_currentRefIndex]);
    SetModel set;

    for(int i = 0; i<snapshot.documents.length; i++){
      set = SetModel.fromMap(snapshot.documents[i].data);
      set.id = snapshot.documents[i].documentID;
      _currentSetList.add(set);
    }
    _currentSet = _currentSetList[_currentSetIndex];
    _maxSetLength = _currentSetList.length;
    _currentExerciseName = _currentSet.exerciseRef;
    notifyListeners();
  }
  next() {
    if(_currentSetIndex < _maxSetLength - 1){
      _currentSetIndex++;
      _currentSet = _currentSetList[_currentSetIndex];
      notifyListeners();

    } else {
      _nextExercise();
    }

  }
  _nextExercise(){
    if(_currentRefIndex  == _exerciseRef.length - 1){
      notifyListeners();
      if(_isLastExerciseSet){
        _isFinished = true;
      }
      _isLastExerciseSet = true;
      return;
    }
    _clearSets();
    _currentRefIndex++;
    _transform();
  }
  _clearSets(){
    _currentSetList = [];
    _currentSetIndex = 0;
  }
  ///Call this method to clear its state to default
  clear(){
    _currentSet = null;
    _exerciseRef = [];
    _currentSetList = [];
    _currentRefIndex = 0;
    _currentSetIndex = 0;
    _isFinished = false;
    _maxSetLength = 0;
    _isLastExerciseSet = false;
  }
}
