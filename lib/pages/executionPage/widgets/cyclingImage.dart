import 'package:flutter/material.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:myfitnessmotivation/providerModel/imageCacheModel.dart';
import 'package:provider/provider.dart';

class CyclingImage extends StatefulWidget {
  @override
  _CyclingImageState createState() => _CyclingImageState();
}

class _CyclingImageState extends State<CyclingImage> {
  @override
  Widget build(BuildContext context) {
    final imageCache = Provider.of<ImageCacheModel>(context, listen: false);
    final executionModel = Provider.of<ExecutionModel>(context);
    return  Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.black12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FittedBox(
            fit: BoxFit.cover,
            child: imageCache.getImage(executionModel.currentExerciseName),
          ),
        ),
      ),
    );
  }
}
