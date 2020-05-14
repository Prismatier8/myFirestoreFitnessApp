

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/statsPages/widgets/planWithStats.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';



class StatsPage extends StatelessWidget {
  Widget build (BuildContext context){
    final planService = Provider.of<PlanService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.TITLE_STATS,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: planService.getDocumentsByStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return PlanWithStats(
                  plan: PlanModel.fromMap(snapshot.data.documents[index].data),
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
}