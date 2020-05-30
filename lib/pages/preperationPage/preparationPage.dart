import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/breakPause.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/reorderableList.dart';
import 'package:myfitnessmotivation/services/muscleGroupService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class PreparationPage extends StatelessWidget {
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final PlanModel planModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: scaffoldState,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          planModel.title,
          style: TextStyle(fontSize: 28),
        ),
      ),
      floatingActionButton: planModel.exerciseRef.isNotEmpty
          ? SizedBox(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                heroTag: Names.HEROTAG_FLOATINGBUTTON,
                onPressed: () async {
                  try{
                    await InternetAddress.lookup("example.com");
                    if(await _isDatabaseConnected(context) == false){
                      scaffoldState.currentState.showSnackBar(SnackBar(content: Text(Names.BASIC_ERRORMESSAGE)));
                      return;
                    }
                    final planService = Provider.of<PlanService>(context, listen: false);
                    await planService.getPlan(planModel.title) ///refresh plan so that navigated page has updated plan
                        .then((value){
                      PlanModel refreshedModel = PlanModel.fromMap(value.data);
                      Navigator.pushNamedAndRemoveUntil(context, NamedRoutes.ROUTE_EXECUTIONPAGE,(_) => false,
                          arguments: refreshedModel);
                    }).catchError((onError){
                      scaffoldState.currentState.showSnackBar(SnackBar(content: Text(Names.BASIC_ERRORMESSAGE)));
                    });
                  } on SocketException catch(_){
                    scaffoldState.currentState.showSnackBar(SnackBar(content: Text("Keine Internetverbindung")));
                    return;
                  }

                },
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
              ),
            )
          : Container(),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: BreakPause(planModel),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: ReorderableList(planModel),
          ),
        ],
      ),
    );
  }
  Future<bool> _isDatabaseConnected(BuildContext context) async{
    final muscleService = Provider.of<MuscleGroupService>(context, listen: false);
    return await muscleService.isConnected();
  }
}
