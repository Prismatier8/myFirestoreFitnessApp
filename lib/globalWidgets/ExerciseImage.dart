import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/providerModel/imageCacheModel.dart';
import 'package:provider/provider.dart';

class ExerciseImage extends StatefulWidget {
  final ExerciseModel exercise;
  ExerciseImage({@required this.exercise});
  @override
  _ExerciseImageState createState() => _ExerciseImageState();
}

class _ExerciseImageState extends State<ExerciseImage> {

  @override
  void initState() {
    super.initState();
    final imageCache = Provider.of<ImageCacheModel>(context, listen: false);
    imageCache.addToCache(widget.exercise.title, widget.exercise.imageRef);
  }
  @override
  Widget build(BuildContext context) {
    final imageCache = Provider.of<ImageCacheModel>(context);
    return Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FittedBox(
          fit: BoxFit.cover,
          child: imageCache.getImage(widget.exercise.title),
        ),
      ),
    );
  }
}
