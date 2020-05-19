import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/imageService.dart';
import 'package:provider/provider.dart';


///isLoading is also Error
class StaticExerciseImage extends StatelessWidget {
  final ExerciseModel exercise;
  StaticExerciseImage(this.exercise);

  @override
  Widget build(BuildContext context) {
    final imageService = Provider.of<ImageService>(context);
    return Container(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FittedBox(
          fit: BoxFit.cover,
          child: FutureBuilder(
              future: imageService.getImageURL(exercise.imageRef),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return Image.network(snapshot.data);
                  } else {
                    return Icon(
                      Icons.image,
                      color: Colors.black26,
                    );
                  }
                } else {
                  return Icon(
                    Icons.image,
                    color: Colors.black26,
                  );
                }
              }),
        ),
      ),
    );
  }
}
