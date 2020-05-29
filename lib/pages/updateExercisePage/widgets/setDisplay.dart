import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/globalWidgets/executionInputRow.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/setPane.dart';

class SetDisplay extends StatefulWidget {
  final SetModel set;
  final String setID;
  SetDisplay({@required this.set, @required this.setID});
  @override
  _SetDisplayState createState() => _SetDisplayState();
}

class _SetDisplayState extends State<SetDisplay> {
  TextEditingController _repetitionController;
  TextEditingController _weightController;
  @override
  void initState() {
    super.initState();
    _repetitionController = TextEditingController();
    _weightController = TextEditingController();
    _repetitionController.text = widget.set.repetition.toString();
    _weightController.text = widget.set.weight.toString();
  }
  @override
  void dispose() {
    super.dispose();
    _repetitionController.dispose();
    _weightController.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Column(
     mainAxisSize: MainAxisSize.min,
     children: <Widget>[
       Center(
         child: Text("Satz: " + widget.set.sequence.toString()),
       ),
       ///WeightRow
       ExecutionInputRow(
         controller: _weightController,
         textSize: 20,
         type: RowType.weight,
         isUpdater: true,
         setID: widget.setID,
       ),
       ///RepetionRow
       ExecutionInputRow(
         controller: _repetitionController,
         textSize: 20,
         type: RowType.repetition,
         isUpdater: true,
         setID: widget.setID,
       )
     ],
   );
  }
}
