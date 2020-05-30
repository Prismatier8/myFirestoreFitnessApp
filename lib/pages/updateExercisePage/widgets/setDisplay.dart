import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/globalWidgets/repetitionDisplay.dart';
import 'package:myfitnessmotivation/globalWidgets/weightDisplay.dart';

class SetDisplay extends StatefulWidget {
  final SetModel set;
  final String setID;
  SetDisplay({@required this.set, @required this.setID});
  @override
  _SetDisplayState createState() => _SetDisplayState();
}

class _SetDisplayState extends State<SetDisplay> {
  @override
  Widget build(BuildContext context) {
   return Column(
     mainAxisSize: MainAxisSize.min,
     children: <Widget>[
       Padding(
         padding: EdgeInsets.only(top: 5),
         child: Center(
           child: Text("Satz: " + widget.set.sequence.toString()),
         ),
       ),
       WeightDisplay(widget.set, widget.setID),
       RepetitionDisplay(widget.set, widget.setID),
     ],
   );
  }
}
