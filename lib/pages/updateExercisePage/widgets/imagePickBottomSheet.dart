import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';

class ImagePickBottomSheet extends StatelessWidget {
  final ExerciseModel exercise;
  ImagePickBottomSheet(this.exercise);
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///shoot photo
          InkWell(
            onTap:  () async{
              var image = await ImagePicker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, image);
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.photo_camera,
                    size: 30,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Foto schießen",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ),
          ///take photo from gallery
          InkWell(
            onTap: () async{
              var image = await ImagePicker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, image);
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.photo,
                    size: 30,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Foto aus Galerie",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
