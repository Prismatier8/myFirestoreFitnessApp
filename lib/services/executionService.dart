import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/myDBAPI.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

class ExecutionService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.EXECUTIONS);

  addExecution(ExecutionData execution){

    _api.addDocumentWithAutoID(execution.toJson());
  }

}