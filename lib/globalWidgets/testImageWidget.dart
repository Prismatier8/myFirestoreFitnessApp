import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/imageService.dart';
import 'package:provider/provider.dart';

///Not in use!!!
class TestImageWidget extends StatefulWidget {
  final ExerciseModel exercise;
   TestImageWidget({@required this.exercise});
  _TestImageWidgetState createState() => _TestImageWidgetState();
}

class _TestImageWidgetState extends State<TestImageWidget> {
  var _currentNetworkImage;
  @override
  Widget build(BuildContext context) {
    final imageService = Provider.of<ImageService>(context, listen: false);
    return Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FittedBox(
            fit: BoxFit.cover,
            child: FutureBuilder(
                future: _getImage(context, imageService),
                builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
                  if (snapshot.hasData) {
                    _currentNetworkImage = snapshot.data;
                    return _currentNetworkImage;
                  } else {
                    return _currentNetworkImage == null
                        ? Icon(
                            Icons.image,
                            color: Colors.black26,
                          )
                        : _currentNetworkImage;
                  }
                })),
      ),
    );
  }

  Future<Image> _getImage(
      BuildContext context, ImageService imageService) async {
    final exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    ExerciseModel refreshedExercise =
        await exerciseService.getExerciseData(widget.exercise.title);
    return await imageService.getImage(refreshedExercise.imageRef);
  }
}
