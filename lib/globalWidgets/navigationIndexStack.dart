
import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/pages/exercisePage/exercisePage.dart';
import 'package:myfitnessmotivation/pages/statsPage/statsPage.dart';
import 'package:myfitnessmotivation/pages/trainingPage/trainingPage.dart';
import 'package:myfitnessmotivation/providerModel/navigationModel.dart';
import 'package:provider/provider.dart';

class NavigationIndexStack extends StatefulWidget{
  _NavigationIndexStackState createState() => _NavigationIndexStackState();
}
class _NavigationIndexStackState extends State<NavigationIndexStack>{
  Widget build (BuildContext context){
    return IndexedStack(
      index: Provider.of<NavigationModel>(context).getIndex(),
      children: <Widget>[
        TrainingPage(),
        StatsPage(),
        ExercisePage(),
      ],
    );
  }
}

