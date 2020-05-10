import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/services/setService.dart';

class ExecutionModel extends ChangeNotifier {
  final SetService _setService = SetService();
  final ExecutionService _executionService = ExecutionService();

  PlanModel _plan;
  List<dynamic> _exerciseRef = [];
  bool _isFinished = false;
  List<SetModel> _currentSetList = [];
  SetModel _currentSet;
  int _currentRefIndex = 0;
  int _currentSetIndex = 0;
  String _currentExerciseName;
  int _maxSetLength = 0;

  SetModel getCurrentSet(){
    return _currentSet;
  }
  get currentExerciseName => _currentExerciseName;
  get isFinished => _isFinished;
  get currentSetList => _currentSetList;
  get maxSetLength => _maxSetLength;
  String getCurrentSetIndex(){
   return (_currentSetIndex + 1).toString();
  }

  init(PlanModel plan) async{
    _currentExerciseName = plan.exerciseRef[0];
    _plan = plan;
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
    _currentExerciseName = _currentSet.exerciseRef;
    _maxSetLength = _currentSetList.length;
    notifyListeners();
  }
  next(String currentWdh, String currentKg) async{
    if(_currentSetIndex < _maxSetLength - 1){
      _incrementSetIndex();
      notifyListeners();

    } else {
      _nextExercise();
    }
    await _updateSet(currentWdh, currentKg);
    _addExecution(currentWdh, currentKg);
  }
  _incrementSetIndex(){
    _currentSetIndex++;
    _currentSet = _currentSetList[_currentSetIndex];
  }
  _nextExercise(){
    if(_currentRefIndex  == _exerciseRef.length - 1){
      _isFinished = true;
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
  _updateSet(String currentWdh, String currentKg) async{
    Map<String, dynamic> map = {
      "weight" : double.parse(currentKg),
      "repetition" : int.parse(currentWdh)};
     await _setService.updateSet(_currentSet.id, map);
  }
  _addExecution(String currentWdh, String currentKg) async {

    final executionData = await _constructExecution();
    _executionService.addExecution(executionData);
  }
  Future<ExecutionData>_constructExecution() async{
    SetModel updatedSet = await _setService.getSetByID(_currentSet.id);
    ExecutionData executionData = ExecutionData(
        repetition: updatedSet.repetition,
        weight: updatedSet.weight,
        planRef: _plan.title,
        exerciseRef: updatedSet.exerciseRef);
    return executionData;
  }
  ///Clears its state to default, should be called when executionModel is not in use anymore
  clear(){
    _currentSet = null;
    _currentSetList = [];
    _currentRefIndex = 0;
    _currentSetIndex = 0;
    _isFinished = false;
    _maxSetLength = 0;
  }
}
