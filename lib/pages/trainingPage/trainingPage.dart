
import 'package:myfitnessmotivation/stringResources/strings.dart';

import 'Widgets/addPlanDialog.dart';
import 'package:flutter/material.dart';

import 'Widgets/plan.dart';

class TrainingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Center(
          child: Text(
            Names.TRAININGPLANS,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,size: 30,),
          onPressed: (){
            showAddPlanDialog(context);
          },
        ),
      ),
      body: Plan(),
    );
  }
  void showAddPlanDialog(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
      builder: (BuildContext context){
          return AddPlanDialog();
      }
    );
  }
}
