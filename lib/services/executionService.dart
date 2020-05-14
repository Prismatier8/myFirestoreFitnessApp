import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/myDBAPI.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

class ExecutionService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.EXECUTIONS);

  addExecution(ExecutionData execution){
    _api.addDocumentWithAutoID(execution.toJson());
  }
  Future<List<ExecutionData>> getExecutions(ExerciseModel exercise, int limit, bool descending) async{
    List<ExecutionData> list = [];
    QuerySnapshot snapshot = await _api.ref.where("exerciseRef", isEqualTo: exercise.title)
        .orderBy("date", descending: descending)
        .limit(limit)
        .getDocuments();

    for(int i = 0; i< snapshot.documents.length; i++){
      list.add(ExecutionData.fromJson(snapshot.documents[i].data));
    }
    return list;
  }
}