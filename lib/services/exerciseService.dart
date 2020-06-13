import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class ExerciseService extends ChangeNotifier {
  MyDBApi _api = MyDBApi(collectionPath: Collection.EXERCISES);
  ///insert exercise
  Future addExercise(ExerciseModel exercise, String id) async {
    await _api.addDocument(exercise.toJson(), id);
  }

  ///deletes specific exercise
  Future deleteExercise(String exerciseName) async {
    await _api.removeDocument(exerciseName);
  }
  ///check if exercise name already exist in database
  Future<bool> exerciseNameExist(String exerciseName) async{
    QuerySnapshot snapshot = await _api.ref
        .where("title", isEqualTo: exerciseName)
        .getDocuments();
    if(snapshot.documents.length == 0){
      return false;
    } else{
      return true;
    }
  }
  ///reeturns all exercise documents as QuerySnapshot by stream
  Stream<QuerySnapshot> getExercisesByStream() {
    return _api.streamDataCollection();
  }
  ///updates exercise with new values from the map of the caller
  Future updateExercise(String exerciseName, Map<String, dynamic> data) async {
    await _api.updateDocument(data, exerciseName);
  }
  ///add a planreference to an exercise
  addPlanToExercise(String exerciseName, String planName) async {
    List<String> plan = [];
    plan.add(planName);
    Map<String, dynamic> map = {"planReferences": FieldValue.arrayUnion(plan)};

    await updateExercise(exerciseName, map);
  }
  ///deletes a planreference from the exercise
  Future deletePlanFromExercise(String exerciseName, String planName) async {
    List<String> plan = [];
    plan.add(planName);
    Map<String, dynamic> map = {"planReferences": FieldValue.arrayRemove(plan)};

    await updateExercise(exerciseName, map);
  }
  ///get all exercise that has a referencee to a MuscleGroup
  Future<List<ExerciseModel>> getExercisesWithMuscleGroup(
      String muscleGroup) async {
    QuerySnapshot snapshot;
    List<ExerciseModel> exerciseDataList = [];
    if (muscleGroup == "Alle Übungen") {
      snapshot = await _api.ref
          .getDocuments();
    } else {
      snapshot = await _api.ref
          .where("muscleGroupReferences", arrayContains: muscleGroup)
          .getDocuments();
    }

    for (int i = 0; i < snapshot.documents.length; i++) {
      exerciseDataList.add(ExerciseModel.fromJson(snapshot.documents[i].data));
    }
    return exerciseDataList;
  }
  ///get a specific exercise
  Future<ExerciseModel> getExerciseData(String exerciseID) async {
    DocumentSnapshot snapshot = await _api.getDocumentById(exerciseID);
    ExerciseModel exercise = ExerciseModel.fromJson(snapshot.data);
    return exercise;
  }
  ///returns a list of all exercises that are referenced in a plan
  //TODO: REFACTOR
  Future<List<ExerciseModel>> getExercisesFromPlan(PlanModel plan) async {
    List<ExerciseModel> exerciseList = [];

    DocumentSnapshot planSnapshot = await Firestore.instance
        .collection(Collection.PLANS)
        .document(plan.title)
        .get();
    final planModel = PlanModel.fromMap(planSnapshot.data);
    QuerySnapshot exerciseSnapshot = await _api.ref
        .where("planReferences", arrayContains: plan.title)
        .getDocuments();
    List<dynamic> exerciseRef = planModel.exerciseRef;
    for (int i = 0; i < exerciseSnapshot.documents.length; i++) {
      ExerciseModel exercise =
          ExerciseModel.fromJson(exerciseSnapshot.documents[i].data);
      exerciseList.add(exercise);
    }
    final sortedList = _sortList(exerciseList, exerciseRef);
    return sortedList;
  }
  ///The list of exercises that are fetched from the database are not in the correct order
  ///compared to the order of the planReference array in a plan document.
  ///The fetched unsorted list of exercises has to be sorted before returning to the UI
  //TODO: REFACTOR
  List<ExerciseModel> _sortList(
      List<ExerciseModel> exerciseList, List<dynamic> exerciseRef) {
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
