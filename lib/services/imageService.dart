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

  ///uploads an image to the firebase storage.
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
      print("Error in ImageService, uploadImage()");
    }
  }
  ///updates exercise to save image reference in exercise document
  _saveImageRefToExercise(
      String exerciseID, StorageReference storageRef) async {
    Map<String, dynamic> fieldToUpdate = {"imageRef": storageRef.path};
    await _exerciseService.updateExercise(exerciseID, fieldToUpdate);
  }
  ///returns downloadURL when calling this function with image reference
  Future<String> getDownloadURL(String url) async{
    if (url == "") {
      return "";
    }
    String downloadURL = await _instance.ref().child(url).getDownloadURL();
    return downloadURL;
  }
  ///Returns Icon or the downloaded image depends on the image reference. If reference
  ///is empty, than it returns a placeholder icon otherwise the downloaded image
  Future<Widget> getImage(String url) async {

    if (url == "") {
      return Icon(Icons.add_a_photo, color: Colors.black26,);
    }
    String downloadURL = await _instance.ref().child(url).getDownloadURL();
    return Image.network(downloadURL);
  }
  ///deletes image
  deleteImage(String url) {
    _instance.ref().child(url).delete();
  }
}
