import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';

class ImageService extends ChangeNotifier {
  final FirebaseStorage _instance = FirebaseStorage.instance;
  final ExerciseService _exerciseService = ExerciseService();

   uploadImage(File image, ExerciseModel exercise) {
    if (image == null) {
      return;
    }
    try {
      Uint8List bytes = image.readAsBytesSync();
      final StorageReference storageReference =
          _instance.ref().child("/Images/${exercise.title}");
      _saveImageRefToExercise(exercise.title, storageReference);
      if(exercise.imageRef.isNotEmpty){
        storageReference.delete();
      }
      storageReference.putData(bytes).onComplete.whenComplete((){
        notifyListeners();
      });

    } catch (e) {
      ///?
    }
  }
  _saveImageRefToExercise(String exerciseID, StorageReference storageRef)  {
    Map<String, dynamic> fieldToUpdate = {"imageRef" : storageRef.path};
     _exerciseService.updateExercise(exerciseID, fieldToUpdate);
  }
  Future<String> getImageURL(String url) async {
    if(url == ""){
      return "";
    }
    String downloadURL = await _instance.ref().child(url).getDownloadURL();
    return downloadURL;
  }
  deleteImage(String url){
     _instance.ref().child(url).delete();
  }
}
