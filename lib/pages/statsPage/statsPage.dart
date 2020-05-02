

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';



class StatsPage extends StatelessWidget {
  Widget build (BuildContext context){
    final planService = Provider.of<PlanService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Center(
          child: Text(
            Names.TITLE_STATS,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}