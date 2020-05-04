import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class BreakPauseDialog extends StatefulWidget {
  final PlanModel planModel;
  BreakPauseDialog(this.planModel);
  @override
  _BreakPauseDialogState createState() => _BreakPauseDialogState();
}

class _BreakPauseDialogState extends State<BreakPauseDialog> {
  TextEditingController _controller;
  List<bool> isSelected = [];
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.planModel.breakPause.toString();
    isSelected.add(widget.planModel.audioSignal);
    isSelected.add(widget.planModel.vibrationSignal);
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planService = Provider.of<PlanService>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Center(child: Text("Ruhedauer einstellen")),
      actions: <Widget>[
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          child: Text(Names.BASIC_ACCEPT,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: (){
            _updatePlan(planService);
            Navigator.pop(context, "");
          },
        ),
      ],
      content: Container(
        width: 180,
        height: 150,
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Ruhedauer in Sekunden",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Signalart",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              children: <Widget>[
                Icon(Icons.hearing
                ),
                Icon(Icons.vibration),
              ],
              onPressed: (index){
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
  _updatePlan(PlanService planService){
    Map<String, dynamic> update = {
      "breakPause" : int.parse(_controller.text),
      "audioSignal" : isSelected[0],
      "vibrationSignal" : isSelected[1],
    };
    planService.updatePlan(widget.planModel.title, update);
  }
}
