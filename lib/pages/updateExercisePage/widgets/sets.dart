import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/setDisplay.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';
class Sets extends StatefulWidget {
  final ExerciseModel exerciseModel;
  Sets({@required this.exerciseModel});
  @override
  _SetsState createState() => _SetsState();
}

class _SetsState extends State<Sets> {
  @override
  Widget build(BuildContext context) {

    final setService = Provider.of<SetService>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: FutureBuilder(
        future: setService.getReferencedDocuments(widget.exerciseModel.title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> setLengthSnapshot){
          if(setLengthSnapshot.hasData){
            return ListView.separated(
              itemCount: setLengthSnapshot.data.documents.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index){
                  return FutureBuilder(
                    future: setService.getReferencedSetBySequence(
                        widget.exerciseModel.title,
                        index + 1),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> setSnapshot){
                      if(setSnapshot.hasData){
                        return SetDisplay(
                            set: SetModel.fromMap(setSnapshot.data.documents[0].data),
                            setID: setSnapshot.data.documents[0].documentID,);
                      } else if (setSnapshot.hasError){
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  );
              },

            );
          } else if(setLengthSnapshot.hasError){
            return Center(
              child: Text(Names.BASIC_ERRORMESSAGE),
            );
          } else{
            return Container();
          }
        },
      ),
    );
  }
}
