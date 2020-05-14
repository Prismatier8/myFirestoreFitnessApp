import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';

class ExerciseWithStats extends StatelessWidget {
  final exercisesSnapshot;
  final builderIndex;
  ExerciseWithStats({@required this.exercisesSnapshot, @required this.builderIndex});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, NamedRoutes.ROUTE_STAT_SINGLEEXERCISEPAGE,
              arguments: exercisesSnapshot.data[builderIndex]);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(exercisesSnapshot.data[builderIndex].title,
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
                Spacer(),
                Container(), //TODO: Stat icon depending on result
              ],
            ),
          ),
        ),
      ),
    );
  }
}
