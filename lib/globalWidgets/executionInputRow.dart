import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/setPane.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:provider/provider.dart';

enum _UpdateType { increment, decrement }

///NOT IN USE
class ExecutionInputRow extends StatefulWidget {
  final TextEditingController controller;
  final double textSize;
  final RowType type;
  final isUpdater;
  final String setID;
  ExecutionInputRow(
      {@required this.controller,
      @required this.textSize,
      @required this.type,
      @required this.isUpdater,
      this.setID});

  @override
  _ExecutionInputRowState createState() => _ExecutionInputRowState();
}

class _ExecutionInputRowState extends State<ExecutionInputRow> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Row(

      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: widget.type == RowType.repetition
                ? Text(
                    "Wiederholung",
                    style: TextStyle(
                      fontSize: widget.textSize,
                    ),
                  )
                : Text(
                    "Gewicht",
                    style: TextStyle(
                      fontSize: widget.textSize,
                    ),
                  )),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Container(
            height: 50,
            width: 55,
            child: TextField(

              onSubmitted: (va){
                print("okok");
              },
              onEditingComplete: (){
                print("okok");
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();

                if(widget.isUpdater){
                  final setService = Provider.of<SetService>(context, listen: false);
                  if(widget.type == RowType.repetition){
                    setService.updateRepetition(widget.setID, widget.controller.text);
                  } else{
                    setService.updateWeight(widget.setID, widget.controller.text);
                  }
                }
              },
                maxLength: 6,
                keyboardType: TextInputType.number,
                inputFormatters: widget.type == RowType.repetition
                    ? [WhitelistingTextInputFormatter.digitsOnly]
                    : [DecimalTextInputFormatter(
                  activatedNegativeValues: false,
                  decimalRange: 2
                )],
                controller: widget.controller,
                decoration: widget.type == RowType.repetition
                    ? InputDecoration(
                        counterText: "",
                        labelText: "Wdh.",
                      )
                    : InputDecoration(
                        counterText: "",
                        labelText: "Kg",
                      )),
          ),
        ),
        ///Increment
        ButtonTheme(
          minWidth: 0,
          shape: CircleBorder(),
          child: RaisedButton(
            onPressed: () {
             _updateValue(_UpdateType.increment);
            },
            color: Theme.of(context).accentColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
        ///decrement
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: ButtonTheme(
            shape: CircleBorder(),
            minWidth: 0,
            child: RaisedButton(
              onPressed: () {
               _updateValue(_UpdateType.decrement);
              },
              color: Theme.of(context).accentColor,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
  //TODO: NEED TO REFACTORED!!!!!!!!!!!!
  _updateValue(_UpdateType updateType) {
    if (widget.type == RowType.repetition) {
      int currentValue;
      if (updateType == _UpdateType.increment) {
        try {
          currentValue = int.parse(widget.controller.text);
          currentValue++;
          widget.controller.text = currentValue.toString();
        } catch (e) {
          currentValue = 0;
          widget.controller.text = currentValue.toString();
        }
      } else {
        try {
          currentValue = int.parse(widget.controller.text);
          if (currentValue == 0) {
            return;
          }
          currentValue--;
          widget.controller.text = currentValue.toString();
        } catch (e) {
          currentValue = 0;
          widget.controller.text = currentValue.toString();
        }
      }
      if(widget.isUpdater){
        final setService = Provider.of<SetService>(context, listen: false);
        setService.updateWeight(widget.setID, widget.controller.text);
      }
    } else {
      // RowType.weight
      final double step = 0.25;
      double currentValue;
      if (updateType == _UpdateType.increment) {
        try {
          currentValue = double.parse(widget.controller.text);
          currentValue = currentValue + step;
          widget.controller.text = currentValue.toString();
        } catch (e) {
          currentValue = 0.0;
          widget.controller.text = currentValue.toString();
        }
      } else {
        try {
          currentValue = double.parse(widget.controller.text);
          if ((currentValue - step) < 0) {
            currentValue = 0.0;
            widget.controller.text = currentValue.toString();
            return;
          }
          currentValue = currentValue - step;
          widget.controller.text = currentValue.toString();
        } catch (e) {
          currentValue = 0.0;
          widget.controller.text = currentValue.toString();
        }
      }
      if(widget.isUpdater){
        final setService = Provider.of<SetService>(context, listen: false);
          setService.updateWeight(widget.setID, widget.controller.text);
      }
    }
  }
}
class DecimalTextInputFormatter extends TextInputFormatter {

  DecimalTextInputFormatter({int decimalRange, bool activatedNegativeValues})
      : assert(decimalRange == null || decimalRange >= 0,
  'DecimalTextInputFormatter declaretion error') {
    String dp = (decimalRange != null && decimalRange > 0) ? "([.][0-9]{0,$decimalRange}){0,1}" : "";
    String num = "[0-9]*$dp";

    if(activatedNegativeValues) {
      _exp = new RegExp("^((((-){0,1})|((-){0,1}[0-9]$num))){0,1}\$");
    }
    else {
      _exp = new RegExp("^($num){0,1}\$");
    }
  }

  RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if(_exp.hasMatch(newValue.text)){
      return newValue;
    }
    return oldValue;
  }
}
