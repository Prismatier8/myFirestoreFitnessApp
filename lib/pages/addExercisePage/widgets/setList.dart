import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:provider/provider.dart';

enum RowType {weight, repetition}
class SetList extends StatefulWidget {
  final int setQuantity;
  SetList(this.setQuantity);

  @override
  _SetListState createState() => _SetListState();
}
//TODO: Zero Values in TextFields should be covered
class _SetListState extends State<SetList> {
  final double _defaultTextSize = 15;
  List<String> weightList;
  List<String> repetitionList;
  @override
  Widget build(BuildContext context) {
    final exerciseService = Provider.of<ExerciseService>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 400,

      child: Card(
        child: ListView.separated(
          itemCount: widget.setQuantity,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text("Set: " + (index + 1).toString(),
                    style: TextStyle(fontSize: _defaultTextSize),
                  ),
                ),
                getRow(RowType.weight),
                getRow(RowType.repetition),
              ],
            );
          },
        ),
        //child: ,
      ),
    );
  }
  Row getRow(RowType rowType){
    if(RowType.weight == rowType){
      return Row(
        children: <Widget>[
          Text("Gewicht",
              style: TextStyle(fontSize: _defaultTextSize)),
          Spacer(),
          Container(
            width: 100,
            child: TextField(
              onEditingComplete: (){

              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Kg",
              ),
            ),
          ),
        ],
      );
    }
    else{
      return Row(
        children: <Widget>[
          Text("Wiederholungen",
              style: TextStyle(fontSize: _defaultTextSize)),
          Spacer(),
          Container(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Wdh.",
              ),
            ),
          ),
        ],
      );
    }
  }
}
