import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/exercisePage/exercisePage.dart';
import 'package:myfitnessmotivation/pages/statsPages/statsPage.dart';
import 'package:myfitnessmotivation/pages/trainingPage/trainingPage.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  int _currentIndex = 0;
  final List<Widget> _stack= [
    TrainingPage(),
    StatsPage(),
    ExercisePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            title: Text(Names.NAVIGATION_TRAINING),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text(Names.TITLE_STATS),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text(Names.NAVIGATION_EXERCISES),
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).accentColor,
      ),
      body: _stack[_currentIndex],
    );
  }
}
