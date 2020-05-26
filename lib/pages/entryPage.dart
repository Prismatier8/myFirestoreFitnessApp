import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/exercisePage/exercisePage.dart';
import 'package:myfitnessmotivation/pages/exercisePage/widgets/addExerciseDialog.dart';
import 'package:myfitnessmotivation/pages/statsPages/statsPage.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/addPlanDialog.dart';
import 'package:myfitnessmotivation/pages/trainingPage/trainingPage.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  PageController _pageController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(_currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              _currentIndex != 0
                  ///One
                  ? IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.play_circle_filled,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(0);
                        });
                      },
                    )
                  : IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.play_circle_filled,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(0);
                        });
                      },
                    ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                ///Two
              _currentIndex != 1
                  ? IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.fitness_center,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(1);
                        });
                      },
                    )
                  : IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.fitness_center,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(1);
                        });
                      },
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              ///Three
              _currentIndex != 2
                  ? IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.insert_chart,
                        color: Colors.black38,
                      ),
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(2);
                        });
                      },
                    )
                  : IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.insert_chart,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _pageController.jumpToPage(2);
                        });
                      },
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        onPageChanged: (int) {
          _currentIndex = int;
        },
        controller: _pageController,
        children: <Widget>[
          TrainingPage(),
          ExercisePage(),
          StatsPage(),
        ],
      ),
    );
  }

  void _showAddPlanDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AddPlanDialog();
        });
  }

  _showAddExerciseDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AddExerciseDialog();
        });
  }

  Widget _getFloatingActionButton(int index) {
    if (index == 0) {
      return FloatingActionButton(
          heroTag: Names.HEROTAG_FLOATINGBUTTON,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            _showAddPlanDialog(context);
          });
    } else if (index == 1) {
      return FloatingActionButton(
        heroTag: "addExercise",
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          _showAddExerciseDialog(context);
        },
      );
    } else {
      return null;
    }
  }
  /*
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

   */
}
