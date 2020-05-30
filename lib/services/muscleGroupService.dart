import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/collectionStrings.dart';

import 'myDBAPI.dart';

class MuscleGroupService extends ChangeNotifier {
  MyDBApi _api = MyDBApi(collectionPath: Collection.MUSCLEGROUPS);

  Stream<QuerySnapshot> getMuscleGroupsByStream() {
    return _api.streamDataCollection();
  }
}
