
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/chooseExercisePage.dart';
import 'package:myfitnessmotivation/pages/entryPage.dart';
import 'package:myfitnessmotivation/pages/executionPage/executionPage.dart';
import 'package:myfitnessmotivation/pages/preperationPage/preparationPage.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/updateExercisePage.dart';
import 'package:myfitnessmotivation/providerModel/breakPauseModel.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
import 'package:myfitnessmotivation/providerModel/navigationModel.dart';
import 'package:myfitnessmotivation/providerModel/setQuantityModel.dart';
import 'package:myfitnessmotivation/providerModel/tagSelectionModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
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
          ChangeNotifierProvider(create: (context) => SetService(),
          ),
          ChangeNotifierProvider(create: (context) => BreakPauseModel(),
          ),
          ChangeNotifierProvider(create: (context) => ExecutionModel(),
          ),
          ChangeNotifierProvider(create: (context) => ExecutionService()
          ),
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
        NamedRoutes.ROUTE_ADDEXERCISEPAGE : (context) => UpdateExercisePage(),
        NamedRoutes.ROUTE_CHOOSEEXERCISEPAGE : (context) => ChooseExercisePage(),
        NamedRoutes.ROUTE_PREPERATIONPAGE : (context) => PreparationPage(),
        NamedRoutes.ROUTE_EXECUTIONPAGE : (context) => ExecutionPage(),
        NamedRoutes.ROUTE_NAVIGATIONSTACK : (context) => EntryPage(),
      },
      theme: ThemeData(accentColor: Colors.amber),
      home: EntryPage(),
    );
  }

}
