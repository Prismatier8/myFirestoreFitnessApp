

import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/globalWidgets/myBottomNavigationBar.dart';
import 'package:myfitnessmotivation/globalWidgets/navigationIndexStack.dart';
import 'package:myfitnessmotivation/pages/addExercisePage/addExercisePage.dart';
import 'package:myfitnessmotivation/providerModel/navigationModel.dart';
import 'package:myfitnessmotivation/providerModel/setQuantityModel.dart';
import 'package:myfitnessmotivation/providerModel/tagSelectionModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavigationModel(),
          ),
          ChangeNotifierProvider(create: (context) => TagSelectionModel(),
          ),
          ChangeNotifierProvider(create: (context) => PlanService(),
          ),
          ChangeNotifierProvider(create: (context) => ExerciseService(),
          ),
          ChangeNotifierProvider(create: (context) => SetQuantityModel(),
          ),
          ChangeNotifierProvider(create: (context) => SetService(),),
        ],
        child: MyApp(
        ),
      ));



}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NamedRoutes.ROUTE_ADDEXERCISEPAGE : (context) => AddExercisePage(),
      },
      theme: ThemeData(accentColor: Colors.amber),
      home: Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(),
        body: NavigationIndexStack(),
      ),
    );
  }

}
