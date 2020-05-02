import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:provider/provider.dart';
enum _RowType {weight, repetition}
class Sets extends StatefulWidget {
  final ExerciseModel exerciseModel;
  Sets({@required this.exerciseModel});
  @override
  _SetsState createState() => _SetsState();
}

class _SetsState extends State<Sets> {
  final double _defaultTextSize = 15;
  @override
  Widget build(BuildContext context) {

    final setService = Provider.of<SetService>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Card(
        child: FutureBuilder(
          future: setService.getReferencedDocuments(widget.exerciseModel.title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              return ListView.separated(
                itemCount: snapshot.data.documents.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text("Set: " + (index + 1).toString(),
                            style: TextStyle(fontSize: _defaultTextSize),
                          ),
                        ),
                        rowFuture(setService, index),
                      ],
                    );
                },

              );
            } else if(snapshot.hasError){
              return Center(
                child: Text("Error Occured"),
              );
            } else{
              return Container();
            }
          },
        ),
      ),
    );
  }
  Widget rowFuture (SetService setService, int index){
    return FutureBuilder(
      future: setService.getReferencedDocumentBySequence(widget.exerciseModel.title, index + 1),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          return Column(
           children: <Widget>[
             getRow(_RowType.weight, setService, snapshot),
             getRow(_RowType.repetition, setService, snapshot),
           ],
          );
        } else if(snapshot.hasError){
          return Text("Error Occured");
        }else {
          return Container();
        }
      },
    );
  }
  Widget getRow(_RowType rowType, SetService setService, snapshot){
    SetModel setModel = _constructModel(snapshot);
    if(_RowType.weight == rowType){
      return Row(
        children: <Widget>[
          Text("Gewicht",
              style: TextStyle(fontSize: _defaultTextSize)),
          Spacer(),
          Container(
            width: 100,
            child: TextFormField(
              inputFormatters: [BlacklistingTextInputFormatter(RegExp("[ -,-]"))],
              initialValue: setModel.weight.toString(),
              onChanged: (currentWeightValue){
                final value = _transformEmptyText(currentWeightValue);
                _updateSet(setService, snapshot, double.parse(value), _RowType.weight);
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
            child: TextFormField( //TODO: Only numbers should be possible to add
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              initialValue: setModel.repetition.toString(),
              onChanged: (currentRepetitionValue){
                final value = _transformEmptyText(currentRepetitionValue);
                _updateSet(setService, snapshot, int.parse(value), _RowType.repetition);
              },
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
  SetModel _constructModel(AsyncSnapshot<QuerySnapshot> snapshot){
    return SetModel.fromMap(snapshot.data.documents[0].data);
  }
  _updateSet(SetService setService, AsyncSnapshot<QuerySnapshot> snapshot, num value, _RowType type){
    final String documentID = snapshot.data.documents[0].documentID;
    if(_RowType.weight == type){
      setService.updateSet(documentID, {"weight" : value});
    } else{
      setService.updateSet(documentID, {"repetition" : value});
    }
  }
  String _transformEmptyText(String value){
    if(value.isEmpty){
      return "0";
    }
    else{
      return value;
    }
  }
}
