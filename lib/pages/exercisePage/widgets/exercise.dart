import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/ExerciseImage.dart';
import 'package:myfitnessmotivation/pages/exercisePage/widgets/deleteExerciseDialog.dart';
import 'package:myfitnessmotivation/providerModel/imageCacheModel.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class Exercise extends StatefulWidget {
  final ExerciseModel exerciseModel;

  Exercise(this.exerciseModel);
  _ExerciseState createState() => _ExerciseState();
}
class _ExerciseState extends State<Exercise>{

  @override
  void initState() {
    super.initState();
    final imageCache = Provider.of<ImageCacheModel>(context, listen: false);
    //final imageService = Provider.of<ImageService>(context, listen: false);
    imageCache.addToCache(widget.exerciseModel.title, widget.exerciseModel.imageRef);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onLongPress: () {
              _showDeleteExerciseDialog(context);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ExerciseImage(
                  exercise: widget.exerciseModel,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    widget.exerciseModel.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, NamedRoutes.ROUTE_ADDEXERCISEPAGE,
                          arguments: widget.exerciseModel)
                      .then((value){
                        setState(() {
                          print("isCalled!!! on " + widget.exerciseModel.title);
                        });
                      });
                    },
                    child: Icon(
                      Icons.settings,
                      color: Theme.of(context).accentColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteExerciseDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DeleteExerciseDialog(widget.exerciseModel);
        });
  }
}
