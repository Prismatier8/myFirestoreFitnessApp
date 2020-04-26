import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class PlanService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.PLANS);

  Future addPlan(Plan plan, String id) async {
    await _api.addDocument(plan.toJson(), id);
}

}
