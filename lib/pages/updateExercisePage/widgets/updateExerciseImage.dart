import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/imagePickBottomSheet.dart';
import 'package:myfitnessmotivation/providerModel/imageCacheModel.dart';
import 'package:myfitnessmotivation/services/imageService.dart';
import 'package:provider/provider.dart';

class UpdateExerciseImage extends StatefulWidget {
  final ExerciseModel exercise;
  UpdateExerciseImage(this.exercise);
  @override
  _UpdateExerciseImageState createState() => _UpdateExerciseImageState();
}

class _UpdateExerciseImageState extends State<UpdateExerciseImage> {
  @override
  Widget build(BuildContext context) {
    final imageService = Provider.of<ImageService>(context, listen: false);
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: _showBottomSheet,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Consumer<ImageCacheModel>(
            builder: (context, imageCache, _) {
              return FittedBox(
                fit: BoxFit.contain,
                child: imageCache.getImage(widget.exercise.title),
              );
            },
          ),
        ),
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
            context: context,
            builder: (context) => ImagePickBottomSheet(widget.exercise))
        .then((pickedImage) {
      if (pickedImage != null) {
          final imageService =
              Provider.of<ImageService>(context, listen: false);
          final imageCache =
              Provider.of<ImageCacheModel>(context, listen: false);
          imageService.uploadImage(pickedImage, widget.exercise);
          imageCache.addImageToCache(
              widget.exercise.title, Image.file(pickedImage));
      }
    });
  }
}
