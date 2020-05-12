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

  Map<String, List<num>> _currentSetMap; //temporary Map to save values from a SetData

  PlanModel _plan;
  Timestamp _timestamp;
  List<dynamic> _exerciseRef = [];
  bool _isFinished = false;
  List<SetModel> _currentSetList;
  SetModel _currentSet;
  int _currentRefIndex = 0;
  int _currentSetIndex = 0;
  String _currentExerciseName;
  int _maxSetLength = 0;

  //Getter
  get currentExerciseName => _currentExerciseName;
  get isFinished => _isFinished;
  get currentSetList => _currentSetList;
  get maxSetLength => _maxSetLength;
  String getCurrentSetIndex(){
   return (_currentSetIndex + 1).toString();
  }
  SetModel getCurrentSet(){
    return _currentSet;
  }
  //Getter

  ///Stateinitiation, need to be called when starting execution (usually when Building ExecutionPage). It is necessary to call this function
  ///everytime the user wants to start a fresh new execution routine, otherwise this class wont be able to know how many exercises need to
  ///be executed and on which exercise the data has to be fetched.
  init(PlanModel plan) async{
    clear();
    _timestamp = Timestamp.now();
    _currentExerciseName = plan.exerciseRef[0];
    _plan = plan;
    _exerciseRef = plan.exerciseRef;
    await _getNextExerciseSets();
  }
  ///fetches all sets from a specific exercise and saves the current state to the attributes of the class. The cycle process will make sure, that
  ///the currentRefIndex will increment, therefore it will look at the next exerciseReference from the _exerciseRef list, that we get when
  ///initiating the state with init(). The setService will then fetch all sets to the specific exerciseRef.
  ///
  _getNextExerciseSets() async {
    _currentSetList = [];
    _currentSetIndex = 0;
    final QuerySnapshot snapshot = await _setService.getReferencedSetsOrderedBySequence(_exerciseRef[_currentRefIndex]);
    SetModel set;

    //Create SetModel objects for each fetched Set-Document in firestore that references the specific exercise
    for(int i = 0; i<snapshot.documents.length; i++){
      set = SetModel.fromMap(snapshot.documents[i].data);
      set.id = snapshot.documents[i].documentID;
      _currentSetList.add(set);
    }
    _currentSet = _currentSetList[0]; //_currentSetIndex
    _currentExerciseName = _currentSet.exerciseRef;
    _maxSetLength = _currentSetList.length;
    notifyListeners();
  }
  ///When this function is called, the state of this class will change. It will update the currently displayed Set in the executionPage(Setpane widget)
  ///to firestore and add this updatedSet to the a temporary map which will be used to save all sets specified to an exercise at once into
  ///firestore as an Execution-Document.
  ///Also, if the currentSetIndex has reached its maxSetlength of the current exercise, it will start the next exercise, if the
  ///currentSetIndex has not reached its maxSetlength, it will increment the the currentSetIndex and the next set of the exercise will be displayed
  ///in the executionPage
  nextSet(String currentWdh, String currentKg) async{
    await _updateSet(currentWdh, currentKg);
    await _addSetToTemporaryMap();
    if(_currentSetIndex < _maxSetLength - 1){
      _incrementSetIndex();
      notifyListeners();
    } else {
      _nextExercise();
    }
  }
  ///Adds the updatedSet into a temporaryMap
  _addSetToTemporaryMap() async{
    SetModel updatedSet = await _setService.getSetByID(_currentSet.id);
    List<num> setList = [updatedSet.weight, updatedSet.repetition];
    String index = "set" + (_currentSetMap.length + 1).toString();
    _currentSetMap[index] = setList;
  }
  ///Constructs an ExecutionData-Object, that will be saved in firestore as an Execution-Document
  ExecutionData _constructExecutionData(){
    ExecutionData newExecutionData = ExecutionData(
      date: _timestamp,
      planRef: _plan.title,
      exerciseRef: _exerciseRef[_currentRefIndex],
      setMap: _currentSetMap,
    );
    return newExecutionData;
  }
  ///Increments the SetIndex and sets the currentSet to the new SetObject
  _incrementSetIndex(){
    _currentSetIndex++;
    _currentSet = _currentSetList[_currentSetIndex];
  }
  ///This function starts the next exercise. The execution will be saved in firestore and the next cycle of Sets starts for the next exercise
  ///exercise. If the end of the exerciseRef.length is reached, it will stop calling new cycles
  _nextExercise(){
    if(_currentRefIndex  == _exerciseRef.length - 1){
      _isFinished = true;
      _addExecutionToDB();
      return;
    }
    _addExecutionToDB();
    _nextCycle();
  }
  ///start nextCycle
  _nextCycle(){
    _currentRefIndex++;
    _getNextExerciseSets();
  }
  ///Adds an Execution-Document to firestore
  _addExecutionToDB() async{

    ExecutionData executionData = _constructExecutionData();
    _executionService.addExecution(executionData);
    _currentSetMap = {};
  }
  ///Updates a set with new Values
  _updateSet(String currentWdh, String currentKg) async{
    Map<String, dynamic> map = {
      "weight" : double.parse(currentKg),
      "repetition" : int.parse(currentWdh)};
     await _setService.updateSet(_currentSet.id, map);
  }
  ///Wipes state of this class to default values which is called each time of initiation when user wants to visit the executionPage
  clear(){
    _currentSet = null;
    _currentSetList = [];
    _currentRefIndex = 0;
    _currentSetIndex = 0;
    _isFinished = false;
    _maxSetLength = 0;
    _currentSetMap = {};
  }
}
