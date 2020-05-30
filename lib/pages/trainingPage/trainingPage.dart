import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/loginPage/provider/accessHandler.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Widgets/plan.dart';

class TrainingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final planService = Provider.of<PlanService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () {
                final accessHandler =
                    Provider.of<AccessHandler>(context, listen: false);
                accessHandler.logout();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "Ausloggen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Text(
          Names.TITLE_TRAININGPLANS,
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.79,
        child: StreamBuilder(
          stream: planService.getDocumentsByStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Plan(
                    plan:
                        PlanModel.fromMap(snapshot.data.documents[index].data),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text(Names.BASIC_ERRORMESSAGE),
                ),
              );
            } else {
              return Center(

                child: Container(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(

                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
