import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class ExerciseService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.EXERCISES);

  Future addExercise(ExerciseModel exercise, String id) async {
    await _api.addDocument(exercise.toJson(), id);
  }
  ///Not tested
  Future deleteExercise(String exerciseName) async {
    await _api.removeDocument(exerciseName);
  }
  Stream<QuerySnapshot> getDocumentsByStream()  {
    return _api.streamDataCollection();
  }
  Future updateExercise(String exerciseName, Map<String, dynamic> data) async{
    await _api.updateDocument(data, exerciseName);
  }

}