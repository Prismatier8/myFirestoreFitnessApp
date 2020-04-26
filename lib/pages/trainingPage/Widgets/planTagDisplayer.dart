
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/tagWidget.dart';

class PlanTagDisplayer extends StatelessWidget{
  final int tagQuantity;
  PlanTagDisplayer({@required this.tagQuantity});

  Widget build(BuildContext context){
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        itemCount: tagQuantity,
        itemBuilder: (BuildContext context, int index){
          return TagWidget(color: Colors.grey, name: "Donnerstag");
      }),
    );
  }
}