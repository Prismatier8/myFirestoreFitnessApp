import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class MuscleGroupService extends ChangeNotifier {
  MyDBApi _api = MyDBApi(collectionPath: Collection.MUSCLEGROUPS);

  ///get all musclegroups by streaming
  Stream<QuerySnapshot> getMuscleGroupsByStream() {
    return _api.streamDataCollection();
  }
  ///muscleService is not dynamic, because documents cannot be added or deleted. That is why
  ///this function is implemented in muscleServices to simply check for good connection to database
  ///(Matthias): There is a weird bug on my phone that sometimes slows the internet connection way to much
  ///but it does not disconnect me from the internet. If this function is called and that specific document is not fetched
  ///fast enough, it will time out. Use this function to show error message or do something else when
  ///database connection is too slow.
  Future<bool> isConnected() async {
    bool isConnected = false;
    await _api.getDocumentById("Bauch").then((value) {
      isConnected = true;
    }).timeout(Duration(seconds: 2), onTimeout: () {
      isConnected = false;
    });
    return isConnected;
  }
}
