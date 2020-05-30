import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:provider/provider.dart';

enum _UpdateType { increment, decrement }

class WeightDisplay extends StatefulWidget {
  final SetModel set;
  final String setID;
  WeightDisplay(this.set, this.setID);
  @override
  _WeightDisplayState createState() => _WeightDisplayState();
}

class _WeightDisplayState extends State<WeightDisplay> {
  TextEditingController _controller;
  FocusNode _node;
  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _controller = TextEditingController();

  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.set.weight.toString();
    final setService = Provider.of<SetService>(context, listen: false);
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Gewicht",
              style: TextStyle(
                fontSize: 20,
              ),
            )),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Container(
            height: 50,
            width: 55,
            child: TextField(
              focusNode: _node,
                onChanged: (val){
                  setService.updateWeight(widget.setID, _controller.text);
                },
                onEditingComplete: () {
                  _node.unfocus();
                },
                maxLength: 6,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  DecimalTextInputFormatter(
                      activatedNegativeValues: false, decimalRange: 2)
                ],
                controller: _controller,
                decoration: InputDecoration(

                  counterText: "",
                  labelText: "Kg",
                )),
          ),
        ),
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

  _updateValue(_UpdateType updateType) {
    final double step = 0.25;
    double currentValue;
    if (updateType == _UpdateType.increment) {
      try {
        currentValue = double.parse(_controller.text);
        currentValue = currentValue + step;
        _controller.text = currentValue.toString();
      } catch (e) {
        currentValue = 0.0;
        _controller.text = currentValue.toString();
      }
    } else {
      try {
        currentValue = double.parse(_controller.text);
        if ((currentValue - step) < 0) {
          currentValue = 0.0;
          _controller.text = currentValue.toString();
          return;
        }
        currentValue = currentValue - step;
        _controller.text = currentValue.toString();
      } catch (e) {
        currentValue = 0.0;
        _controller.text = currentValue.toString();
      }
    }
    final setService = Provider.of<SetService>(context, listen: false);
    setService.updateWeight(widget.setID, _controller.text);
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({int decimalRange, bool activatedNegativeValues})
      : assert(decimalRange == null || decimalRange >= 0,
            'DecimalTextInputFormatter declaretion error') {
    String dp = (decimalRange != null && decimalRange > 0)
        ? "([.][0-9]{0,$decimalRange}){0,1}"
        : "";
    String num = "[0-9]*$dp";

    if (activatedNegativeValues) {
      _exp = new RegExp("^((((-){0,1})|((-){0,1}[0-9]$num))){0,1}\$");
    } else {
      _exp = new RegExp("^($num){0,1}\$");
    }
  }
  RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_exp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
