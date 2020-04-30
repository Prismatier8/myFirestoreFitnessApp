import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/myDBAPI.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

class SetService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.SETS);

  Future addSet(SetModel set) async {
    await _api.addDocumentWithAutoID(set.toJson());
  }
  Future<QuerySnapshot> getReferencedDocuments(String exerciseID) async {
    return await Firestore.instance.collection(Collection.SETS)
        .where("exerciseRef", isEqualTo: exerciseID).getDocuments();
  }



}