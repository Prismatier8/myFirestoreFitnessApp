import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class ExerciseService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.PLANS);

  Future addExercise(ExerciseModel plan, String id) async {
    await _api.addDocument(plan.toJson(), id);
  }
  ///Not tested
  Future deleteExercise(String planName) async {
    await _api.removeDocument(planName);
  }
  Stream<QuerySnapshot> getDocumentsByStream()  {
    return _api.streamDataCollection();
  }
}