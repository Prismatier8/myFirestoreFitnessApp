import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/myDBAPI.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

class SetService extends ChangeNotifier{
  MyDBApi _api = MyDBApi(collectionPath: Collection.SETS);
  ///insert set
  Future addSet(SetModel set) async {
    await _api.addDocumentWithAutoID(set.toJson());
  }
  ///returns all sets as QuerySnapshot that contains title of exercise
  Future<QuerySnapshot> getReferencedDocuments(String exerciseID) async {
    return await Firestore.instance.collection(Collection.SETS)
        .where("exerciseRef", isEqualTo: exerciseID).getDocuments();
  }
  ///returns one specific plan by setID
  Future<SetModel> getSetByID(String setID) async{
    DocumentSnapshot snapshot = await _api.getDocumentById(setID);
    SetModel set = SetModel.fromMap(snapshot.data);
    return set;
  }
  ///deletes only one specific set. The sequence number is needed to differentiate between the sets
  ///referenced to a specific exercise
  Future deleteSetsBySequenceAndExercise(String exerciseName, int sequence) async{
    QuerySnapshot snapshot =  await _api.ref
        .where("exerciseRef", isEqualTo: exerciseName)
        .where("sequence", isEqualTo: sequence)
        .getDocuments();
    await _api.removeDocument(snapshot.documents[0].documentID);
  }
  ///The Sequence of any SetModel starts with Sequence number 1, if you use this query to get a specific document by its
  ///sequence, please make sure,
  ///that the parameter "index" starts with the number 1 and not with 0
  Future<QuerySnapshot> getReferencedSetBySequence(String exerciseID, int index) async {
    CollectionReference ref  = Firestore.instance.collection(Collection.SETS);
    Query query =  ref.where("exerciseRef", isEqualTo: exerciseID);
    query       =  query.where("sequence", isEqualTo: index);

    return await query.getDocuments();
  }
  ///returns all sets as QuerySnapshot to a specific exerciseID in an ascending order ( Sequence 1, Sequence 2, Sequence 3, ...)
  Future<QuerySnapshot> getReferencedSetsOrderedBySequence(String exerciseID) async {
   return await  _api.ref.where("exerciseRef", isEqualTo: exerciseID).orderBy("sequence", descending: false).getDocuments();
  }
  ///update a specific set. Please note: Each set has an automatic generated ID. The ID is usually saved inside
  ///SetData Object
  Future updateSet(String id, Map<String, dynamic> data) async{
    await _api.updateDocument(data, id);
  }
  ///updates Weight values of a specific set
  updateWeight(String setID, String weight) async{
    Map<String, dynamic> map = {};
    try{
      map = {
        "weight" : double.parse(weight),
      };
    } catch (numberFormatException){
      map = {
        "weight" : 0.0,
      };
    }
    await _api.updateDocument(map, setID);
  }
  ///updates repetition value of a specific set
  updateRepetition(String setID, String repetition) async{
    Map<String, dynamic> map = {};
    try{
      map = {
        "repetition" : int.parse(repetition),
      };
    } catch(numberFormatException){
      map = {
        "repetition" : 0,
      };
    }
    await _api.updateDocument(map, setID);
  }
  ///Delete all Sets from an exercise
  Future deleteSets(String exerciseID) async{
    QuerySnapshot snapshot = await _api.ref.where("exerciseRef", isEqualTo: exerciseID).getDocuments();
    for(int i = 0; i<snapshot.documents.length; i++){
      _api.ref.document(snapshot.documents[i].documentID).delete();
    }
  }




}