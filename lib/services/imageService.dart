import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';

class ImageService extends ChangeNotifier {
  final FirebaseStorage _instance = FirebaseStorage.instance;
  final ExerciseService _exerciseService = ExerciseService();

  uploadImage(File image, ExerciseModel exercise) async {
    if (image == null) {
      return;
    }
    try {
      Uint8List bytes = image.readAsBytesSync();
      final StorageReference storageReference =
          _instance.ref().child("/Images/${exercise.title}");
      await _saveImageRefToExercise(exercise.title, storageReference);
      storageReference.putData(bytes);

    } catch (e) {
      ///?
    }
  }

  _saveImageRefToExercise(
      String exerciseID, StorageReference storageRef) async {
    Map<String, dynamic> fieldToUpdate = {"imageRef": storageRef.path};
    await _exerciseService.updateExercise(exerciseID, fieldToUpdate);
  }
  Future<String> getDownloadURL(String url) async{
    if (url == "") {
      return "";
    }
    String downloadURL = await _instance.ref().child(url).getDownloadURL();
    return downloadURL;
  }
  Future<Widget> getImage(String url) async {

    if (url == "") {
      return Icon(Icons.add_a_photo, color: Colors.black26,);
    }
    String downloadURL = await _instance.ref().child(url).getDownloadURL();
    return Image.network(downloadURL);
  }

  deleteImage(String url) {
    _instance.ref().child(url).delete();
  }
}
