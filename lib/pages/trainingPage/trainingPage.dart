import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';
import 'Widgets/addPlanDialog.dart';
import 'package:flutter/material.dart';
import 'Widgets/plan.dart';

class TrainingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final planService = Provider.of<PlanService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Center(
          child: Text(
            Names.TITLE_TRAININGPLANS,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            heroTag: Names.HEROTAG_FLOATINGBUTTON,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              _showAddPlanDialog(context);
            },
          ),
        ),
      body: StreamBuilder(
        stream: planService.getDocumentsByStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                 children: <Widget>[
                   Plan(
                     plan: PlanModel.fromMap(snapshot.data.documents[index].data),
                   ),
                 ],

                );
              },
            );
          } else if(snapshot.hasError){
            print("ERROR OCCURED IN: TRAININGPAGE STREAMBUILDER PLANDOCUMENTS"); //TODO: Need watch at the end
            return Container();

          }
          else{
            return CircularProgressIndicator();
          }
        },
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
}
