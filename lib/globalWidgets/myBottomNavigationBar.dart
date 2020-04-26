
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/navigationModel.dart';
import 'package:myfitnessmotivation/stringResources/strings.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget{
  const MyBottomNavigationBar();
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}
class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>{

  Widget build(BuildContext context){
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_filled),
          title: Text(Names.NAVIGATION_TRAINING),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart),
          title: Text(Names.NAVIGATION_STATS),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          title: Text(Names.NAVIGATION_EXERCISES),
        ),
      ],
      onTap: (index){
        _changeIndexBasedOnTab(index);
      },
      currentIndex: Provider.of<NavigationModel>(context, listen: false).getIndex(),
      selectedItemColor: Theme.of(context).accentColor,
    );
  }
  _changeIndexBasedOnTab(int index){
    setState(() {
      Provider.of<NavigationModel>(context, listen: false).changeIndex(index);
    });
  }
}