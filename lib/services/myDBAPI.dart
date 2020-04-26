import 'package:cloud_firestore/cloud_firestore.dart';

class MyDBApi{
  final Firestore _db = Firestore.instance;
  final String collectionPath;
  CollectionReference ref;

  MyDBApi({this.collectionPath}) {
    ref = _db.collection(collectionPath);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  addDocument(Map data, String id) {
    ref.document(id).setData(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }
}