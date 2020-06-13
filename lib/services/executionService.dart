import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/myDBAPI.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

class ExecutionService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.EXECUTIONS);
  ///inserts execution
  addExecution(ExecutionData execution){
    _api.addDocumentWithAutoID(execution.toJson());
  }
  /*
  ///returns only the executions, that are linked to a specific exercise (NOT IN USE)
  Future<List<ExecutionData>> getExecutionsOnExercise(ExerciseModel exercise, int limit, bool descending) async{
    List<ExecutionData> list = [];
    QuerySnapshot snapshot = await _api.ref
        .where("exerciseRef", isEqualTo: exercise.title)
        .orderBy("date", descending: descending)
        .limit(limit)
        .getDocuments();

    for(int i = 0; i< snapshot.documents.length; i++){
      list.add(ExecutionData.fromJson(snapshot.documents[i].data));
    }
    return list;
  }

   */
  ///Returns only the executions, that are linked to a specific plan and an exercise
  Future<List<ExecutionData>> getExecutionsOnPlan(PlanModel plan, ExerciseModel exercise, int limit, bool descending) async{
    List<ExecutionData> list = [];
    QuerySnapshot snapshot = await _api.ref
        .where("exerciseRef", isEqualTo: exercise.title)
        .where("planRef", isEqualTo: plan.title)
        .orderBy("date", descending: descending)
        .limit(limit)
        .getDocuments();

    for(int i = 0; i< snapshot.documents.length; i++){
      list.add(ExecutionData.fromJson(snapshot.documents[i].data));
    }
    return list;
  }
  ///Deletes all executions that has a specific exercise as reference
  Future deleteExecutionByExercise(String exerciseID) async{
      QuerySnapshot snapshot = await _api.ref.where("exerciseRef", isEqualTo: exerciseID).getDocuments();
      for(int i = 0; i<snapshot.documents.length; i++){
        _api.ref.document(snapshot.documents[i].documentID).delete();
      }
  }
  ///deletes all executions that has a specific plan as reference
  Future deleteExecutionByPlan(String planID) async{
    QuerySnapshot snapshot = await _api.ref.where("planRef", isEqualTo: planID).getDocuments();
    for(int i = 0; i<snapshot.documents.length; i++){
      _api.ref.document(snapshot.documents[i].documentID).delete();
    }
  }
}