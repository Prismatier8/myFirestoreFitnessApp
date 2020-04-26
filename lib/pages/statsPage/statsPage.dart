

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/strings.dart';
import 'package:provider/provider.dart';



class StatsPage extends StatelessWidget {
  Widget build (BuildContext context){
    final planService = Provider.of<PlanService>(context);
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
        child: RaisedButton(
          child: Text("Add"),
          onPressed: (){
            final plan = Plan(
              title: "Hure",
              tags: [Names.TAGS_MONDAY, Names.TAGS_SUNDAY, Names.TAGS_THURSDAY],
              breakPause: 60,
            );
            planService.addPlan(plan, plan.title);
          }


        ),
      ),
    );
  }
}