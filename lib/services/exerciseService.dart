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
  addPlanToExercise(String exerciseName, String planName) async{
    List<String> plan = [];
    plan.add(planName);
    Map<String, dynamic> map = {"planReferences" : FieldValue.arrayUnion(plan)};

    await updateExercise(exerciseName, map);
  }
  Future deletePlanFromExercise(String exerciseName, String planName) async{
    List<String> plan = [];
    plan.add(planName);
    Map<String, dynamic> map = {"planReferences" : FieldValue.arrayRemove(plan)};

    await updateExercise(exerciseName, map);
  }
  //TODO: REFACTOR
  Future<List<ExerciseModel>> getExerciseModelsFromPlan(PlanModel plan) async {

    List<ExerciseModel> exerciseList = [];

    DocumentSnapshot planSnapshot = await Firestore.instance.collection(Collection.PLANS).document(plan.title).get();
    final planModel = PlanModel.fromMap(planSnapshot.data);
    QuerySnapshot exerciseSnapshot = await _api.ref.where(
        "planReferences", arrayContains: plan.title).getDocuments();
    List<dynamic> exerciseRef = planModel.exerciseRef;
    for (int i = 0; i < exerciseSnapshot.documents.length; i++) {
      ExerciseModel exercise = ExerciseModel.fromJson(
          exerciseSnapshot.documents[i].data);
      exerciseList.add(exercise);
    }
    final sortedList = _sortList(exerciseList, exerciseRef);
    return sortedList;
  }
  //TODO: REFACTOR
 List<ExerciseModel> _sortList(List<ExerciseModel> exerciseList, List<dynamic> exerciseRef){
    List<ExerciseModel> sortedList = [];
    List<String> exerciseListTitleOnly = [];
   for (int i = 0; i < exerciseList.length; i++) {
     exerciseListTitleOnly.add(exerciseList[i].title);
   }

   for (int i = 0; i < exerciseRef.length; i++) {
     int index = exerciseListTitleOnly.indexOf(exerciseRef[i]);
     sortedList.add(exerciseList[index]);
   }
   return sortedList;
  }
  ///TOO SLOW
  /*
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

   */

  

}