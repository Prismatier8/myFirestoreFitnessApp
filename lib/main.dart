import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/chooseExercisePage.dart';
import 'package:myfitnessmotivation/pages/executionPage/executionPage.dart';
import 'package:myfitnessmotivation/pages/executionPage/provider/executionTimerModel.dart';
import 'package:myfitnessmotivation/pages/loginPage/provider/accessHandler.dart';
import 'package:myfitnessmotivation/pages/preperationPage/preparationPage.dart';
import 'package:myfitnessmotivation/pages/rootPage/rootPage.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/multiExercisePage/multiExercisePage.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/singleExercisePage/singleExercisePage.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/updateExercisePage.dart';
import 'package:myfitnessmotivation/providerModel/formFieldValidationModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/breakPauseModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:myfitnessmotivation/providerModel/imageCacheModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/exercisePage/provider/setQuantityModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/statsPages/provider/singleStatCalculationModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/trainingPage/provider/tagSelectionModel.dart';
import 'package:myfitnessmotivation/services/auth/authentication.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/imageService.dart';
import 'package:myfitnessmotivation/services/muscleGroupService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';


///An mich selbst und lese es bitte durch: Schön, dass du dich entschieden hast hier weiter zu arbeiten. Bitte überlege dir vorher wie du
///es schaffen kannst, globale Provider von lokalen Providern zu trennen. Es kann doch nicht sein, dass ich jedes mal einen globalen
///Provider platzieren muss, nur weil ich den Provider auf mehreren Pages verwende. Versuch bitte davor dir zu überlegen,
///wie du globale Provider so gut es geht verhindern kannst. Als Erinnerung für dich: Wird Navigator...push() aufgerufen, wird das gepushte Widget direkt
///unterhalb der MaterialApp() platziert. Ich habe gelesen, dass eventuell jede einzelne Page seinen eigenen Navigator erhält, ob das Sinn macht?? Schau ob
///du vielleicht ein komplexeres Projekt findest, dass mit Provider arbeitet.
///UND BITTE! BEVOR DU IRGENDWAS ASYNCHRONES MACHST: DIREKT FEHLERPOTENTIAL AUSPROGRAMMIEREN UND NICHT FAUL SEIN
void main() async{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TagSelectionModel(),),
      ChangeNotifierProvider(create: (context) => PlanService(),),
      ChangeNotifierProvider(create: (context) => ExerciseService(),),
      ChangeNotifierProvider(create: (context) => SetQuantityModel(),),
      ChangeNotifierProvider(create: (context) => SetService(),),
      ChangeNotifierProvider(create: (context) => BreakPauseModel(),),
      ChangeNotifierProvider(create: (context) => ExecutionModel(),),
      ChangeNotifierProvider(create: (context) => ExecutionService()),
      ChangeNotifierProvider(create: (context) => SingleStatCalculationModel()),
      ChangeNotifierProvider(create: (context) => ImageService()),
      ChangeNotifierProvider(create: (context) => ImageCacheModel()),
      ChangeNotifierProvider(create: (context) => MuscleGroupService()),
      ChangeNotifierProvider(create: (context) => AccessHandler(),),
      ChangeNotifierProvider(create: (context) => Authentication(),),
      ChangeNotifierProvider(create: (context) => FormFieldValidationModel(),),
      ChangeNotifierProvider(create: (context) => ExecutionTimerModel(),),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case NamedRoutes.ROUTE_STAT_SINGLEEXERCISEPAGE:
            return CupertinoPageRoute(
                builder: (_) => SingleExercisePage(), settings: settings);
          case NamedRoutes.ROUTE_STAT_MULTIEXERCISESPAGE:
            return CupertinoPageRoute(
                builder: (_) => MultiExercisePage(), settings: settings);
          case NamedRoutes.ROUTE_ADDEXERCISEPAGE:
            return CupertinoPageRoute(
                builder: (_) => UpdateExercisePage(), settings: settings);
          case NamedRoutes.ROUTE_CHOOSEEXERCISEPAGE:
            return CupertinoPageRoute(
                builder: (_) => ChooseExercisePage(), settings: settings);
          case NamedRoutes.ROUTE_PREPERATIONPAGE:
            return CupertinoPageRoute(
                builder: (_) => PreparationPage(), settings: settings);
          case NamedRoutes.ROUTE_EXECUTIONPAGE:
            return MaterialPageRoute(
                builder: (_) => ExecutionPage(), settings: settings);
          case NamedRoutes.ROUTE_NAVIGATIONSTACK:
            return MaterialPageRoute(
                builder: (_) => RootPage(), settings: settings);
          default:
            return null;
        }
      },
      theme: ThemeData(accentColor: Colors.amber),
      home: RootPage(
      ),
    );
  }
}
