

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/strings.dart';



class StatsPage extends StatelessWidget {
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Center(
          child: Text(
            Names.NAVIGATION_STATS,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}