import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageCacheModel extends ChangeNotifier{

  Map<String, Widget> _cache = {};

  get cache => _cache;

  ///returns Images or icons
  Widget getImage(String exerciseName){
    if(_cache.containsKey(exerciseName)){
      return _cache[exerciseName];
    } else {
      return Icon(Icons.image, color: Colors.black26,);
    }
  }
  ///Adds Image directly to cache, is used when adding picture from gallery or camera
  addImageToCache(String exerciseName, Image image){
    _cache[exerciseName] = image;

    notifyListeners();
  }
  ///Is called on every build() of each Page that contains images. This is because
  ///the download process must start on every page that shows images. Without this behaviour
  ///images would not load into cache because cache is always empty when user starts the app
  ///This function downloads the image and safes result in cache
  addToCache(String exerciseName, String imageRef) async{
    if(_cache.containsKey(exerciseName)){ ///prevent from downloading url when Image is already cached
      return;
    }
    if(imageRef == ""){ ///empty imageRef means no picture in firebase storage
      _cache[exerciseName] = Icon(Icons.image, color: Colors.black26,);
      return;
    }
    String downloadURL = await FirebaseStorage.instance.ref().child(imageRef).getDownloadURL();
    _cache[exerciseName] = Image.network(downloadURL);

    notifyListeners();

  }
  ///Remove image from cache
  removeFromCache(String exerciseName){
    if(_cache.containsKey(exerciseName)){
      _cache.remove(exerciseName);
    }
  }
  ///clear cache
  clear(){
    _cache.clear();
  }
}