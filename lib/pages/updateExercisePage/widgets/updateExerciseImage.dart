import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/imagePickBottomSheet.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
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
          child: FittedBox(
            fit: BoxFit.contain,
            child: Consumer<ImageService>(
              builder: (context, __, _) {
                return FutureBuilder(
                  future: imageService.getImageURL(widget.exercise.imageRef),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isNotEmpty) {
                        return Image.network(snapshot.data);
                      } else {
                        return Icon(
                          Icons.add_a_photo,
                          color: Colors.black26,
                        );
                      }
                    } else {
                      return Icon(
                        Icons.add_a_photo,
                        color: Colors.black26,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  _showBottomSheet() {
    showModalBottomSheet(
            context: context,
            builder: (context) => ImagePickBottomSheet(widget.exercise))
        .then((pickedImage) async{
      if (pickedImage != null) {
        final imageService = Provider.of<ImageService>(context, listen: false);
        imageService.uploadImage(pickedImage, widget.exercise);
      }
    });
  }
}
