import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class PlanService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.PLANS);

  Future addPlan(PlanModel plan, String id) async {
    await _api.addDocument(plan.toJson(), id);
}
  ///Not tested
  Future deletePlan(String planName) async {
    await _api.removeDocument(planName);
  }
  Stream<QuerySnapshot> getDocumentsByStream()  {
      return _api.streamDataCollection();
  }
  updatePlan(PlanModel plan, String id) async{
    await _api.updateDocument(plan.toJson(), id);
  }
}
