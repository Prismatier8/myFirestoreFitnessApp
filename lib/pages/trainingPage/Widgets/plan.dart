
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/planTagDisplayer.dart';

class Plan extends StatelessWidget{
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            height: 80,
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PlanTagDisplayer(tagQuantity: 3),
                      Padding(
                          padding: EdgeInsets.only(left: 20,bottom: 23),
                          child: Text("Planname in Future",
                            style: TextStyle(fontSize: 20),)
                      ),
                    ],
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (){
                      //TODO: Navigate to ExercisesPage connected to plan.
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.update,color: Colors.white,size: 30,),
                          Text("120 Min",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}