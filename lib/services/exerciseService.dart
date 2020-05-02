import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
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
  Future<List<ExerciseModel>> getExercisesFromPlan(String planName) async {

    final planCollectionRef = Firestore.instance.collection(Collection.PLANS);
    final DocumentSnapshot plan =  await planCollectionRef.document(planName).get();

    return await _getExerciseModels(plan);
  }
  Future<List<ExerciseModel>> _getExerciseModels(DocumentSnapshot plan) async{
    final planModel = PlanModel.fromMap(plan.data);
    final List<dynamic> exerciseReferences = planModel.exerciseRef;
    List<ExerciseModel> exerciseModels = [];
    for(int i = 0; i<exerciseReferences.length; i++){
      DocumentSnapshot snapshot = await _api.ref.document(exerciseReferences[i]).get();
      ExerciseModel exerciseModel = ExerciseModel.fromJson(snapshot.data);
      exerciseModels.add(exerciseModel);
    }
    return exerciseModels;
  }

  

}