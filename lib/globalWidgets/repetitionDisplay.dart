import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:provider/provider.dart';

enum _UpdateType { increment, decrement }
class RepetitionDisplay extends StatefulWidget {
  final SetModel set;
  final String setID;
  RepetitionDisplay(this.set, this.setID);
  @override
  _RepetitionDisplayState createState() => _RepetitionDisplayState();
}

class _RepetitionDisplayState extends State<RepetitionDisplay> {
  TextEditingController _controller;
  FocusNode _node;
  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _controller = TextEditingController();
    _controller.text = widget.set.repetition.toString();
  }
  @override
  void didUpdateWidget(RepetitionDisplay oldWidget) {
    if(oldWidget.set != widget.set){
      _controller.text = widget.set.repetition.toString();
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {


    final setService = Provider.of<SetService>(context, listen: false);
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Wiederholungen",
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
                onChanged: (value){
                  setService.updateRepetition(widget.setID, _controller.text);
                },
                focusNode: _node,
                onEditingComplete: () {
                  _node.unfocus();
                },
                maxLength: 3,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: _controller,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Wdh",
                )),
          ),
        ),
        ///increment
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
      int currentValue;
      if (updateType == _UpdateType.increment) {
        try {
          currentValue = int.parse(_controller.text);
          currentValue++;
          _controller.text = currentValue.toString();
        } catch (e) {
          currentValue = 0;
          _controller.text = currentValue.toString();
        }
      } else {
        try {
          currentValue = int.parse(_controller.text);
          if (currentValue == 0) {
            return;
          }
          currentValue--;
          _controller.text = currentValue.toString();
        } catch (e) {
          currentValue = 0;
          _controller.text = currentValue.toString();
        }
    }
      final setService = Provider.of<SetService>(context, listen: false);
      setService.updateRepetition(widget.setID, _controller.text);
  }
}
