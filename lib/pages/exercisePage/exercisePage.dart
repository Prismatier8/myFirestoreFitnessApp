import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';


class ExercisePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.NAVIGATION_EXERCISES,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          heroTag: "addExercise",
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, NamedRoutes.ROUTE_ADDEXERCISEPAGE);
          },
        ),
      ),
      body: Center(
        child: Text("ExercisePage"),
      ),
    );
  }

}