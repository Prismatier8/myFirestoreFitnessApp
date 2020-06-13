import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class PlanService extends ChangeNotifier {
  MyDBApi _api = MyDBApi(collectionPath: Collection.PLANS);

  ///insert plan
  Future addPlan(PlanModel plan, String id) async {
    await _api.addDocument(plan.toJson(), id);
  }
  ///checks if plan name already exist in firestore database
  Future<bool> planNameExist(String planName) async {
    QuerySnapshot snapshot = await _api.ref
        .where("title", isEqualTo: planName)
        .getDocuments();
    if(snapshot.documents.length == 0){
      return false;
    } else {
      return true;
    }

  }
  ///delete plan
  Future deletePlan(String planName) async {
    await _api.removeDocument(planName);
  }
  ///get all plan documents by stream
  Stream<QuerySnapshot> getDocumentsByStream() {
    return _api.streamDataCollection();
  }
  ///returns DocumentSnapshot of plan
  Future<DocumentSnapshot> getPlan(String planName) async {
    return await _api.getDocumentById(planName);
  }
  ///Adds exerciseReferences to plan
  addExerciseToPlan(String planName, Map<String, dynamic> map) async {
    await _api.ref.document(planName).updateData(map);
  }
  ///updates plan
  Future updatePlan(String planName, Map<String, dynamic> data) async {
    await _api.updateDocument(data, planName);
  }
  ///Deletes exercise references from plan
  Future deleteExerciseFromPlans(String exerciseID) async {
    List<String> exerciseIDList = [];
    exerciseIDList.add(exerciseID);
    QuerySnapshot snapshot = await _api.ref
        .where("exerciseRef", arrayContains: exerciseID)
        .getDocuments();
    for (int i = 0; i < snapshot.documents.length; i++) {
      addExerciseToPlan(PlanModel.fromMap(snapshot.documents[i].data).title,
          {"exerciseRef" : FieldValue.arrayRemove(exerciseIDList)});
    }
  }
}
