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

  ///The Sequence of any SetModel starts with Sequence number 1, if you use this query, please make sure,
  ///that the parameter "index" starts with the number 1 and not with 0
  Future<QuerySnapshot> getReferencedDocumentBySequence(String exerciseID, int index) async {
    CollectionReference ref  = Firestore.instance.collection(Collection.SETS);
    Query query =  ref.where("exerciseRef", isEqualTo: exerciseID);
    query       =  query.where("sequence", isEqualTo: index);

    return await query.getDocuments();
  }
  Future updateSet(String id, Map<String, dynamic> data) async{
    await _api.updateDocument(data, id);
  }




}