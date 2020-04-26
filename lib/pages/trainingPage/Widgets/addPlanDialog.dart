import 'package:myfitnessmotivation/pages/trainingPage/Widgets/tagWidget.dart';
import 'package:myfitnessmotivation/stringResources/strings.dart';
import 'addPlanInputText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/tagSelectionModel.dart';
import 'package:provider/provider.dart';

class AddPlanDialog extends StatefulWidget {
  _AddPlanDialogState createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {

  TextEditingController controller;
  final int selectedTagLimit = 3;
  bool isTitleMissing = false;

  initState() {
    super.initState();
    controller = TextEditingController();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    final TagSelectionModel tagSelectionModel =
      Provider.of<TagSelectionModel>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        height: 250,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                Names.ADDPLAN_TITLE,
                style: TextStyle(fontSize: 20),
              ),
            ),
            AddPlanInputText(controller: controller, isTitleMissing: isTitleMissing,),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                Names.BASIC_TAGS,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              children: <Widget>[
                TagWidget(
                  name: Names.TAGS_MONDAY,
                  color: Colors.lightBlueAccent,
                ),
                TagWidget(name: Names.TAGS_TUESDAY, color: Colors.green),
                TagWidget(name: Names.TAGS_WEDNESDAY, color: Colors.orangeAccent),
              ],
            ),
            Row(
              children: <Widget>[
                TagWidget(name: Names.TAGS_THURSDAY, color: Colors.deepPurpleAccent),
                TagWidget(name: Names.TAGS_FRIDAY, color: Colors.redAccent),
                TagWidget(name: Names.TAGS_SATURDAY, color: Colors.pinkAccent),
              ],
            ),
            Row(
              children: <Widget>[
                TagWidget(name: Names.TAGS_SUNDAY, color: Colors.indigoAccent),
                validateSelectedTagQuantity(tagSelectionModel) //returns error text
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        //CancelButton
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {
            clearTagSelectionQuantity(tagSelectionModel);
            Navigator.pop(context);
          },
          child: Text(
            Names.ADDPLAN_CANCELBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
        //AddButton
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (checkSelectionQuantity(tagSelectionModel)) {
              setState(() {});
            } else if (checkMissingTitle()) {
              setState(() {
                isTitleMissing = true;
              });
            } else {
              clearTagSelectionQuantity(tagSelectionModel);
              Navigator.pop(context);
            }
          },
          child: Text(
            Names.ADDPLAN_ADDBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
  bool checkSelectionQuantity(TagSelectionModel tagSelectionModel) {
    return tagSelectionModel.currentSelectionQuantity > selectedTagLimit;
  }

  bool checkMissingTitle() {
    return controller.text.isEmpty;
  }

  //resets the current currentTagSelectionQuantity in TagSelectionQuantityModel to 0. The Counter has to reset when the user is leaving the AddPlanDialog.
  //The counter will be 0 every time the user is trying to add a freshly new Plan
  clearTagSelectionQuantity(TagSelectionModel tagSelectionModel) {
    tagSelectionModel.clear();
  }
  //Display ErrorText if selected tags exceeds tag limit
  Text validateSelectedTagQuantity(TagSelectionModel tagSelectionModel) {
    if (checkSelectionQuantity(tagSelectionModel)) {
      return Text(Names.ADDPLAN_TAGERRORMESSAGE,
          style: TextStyle(color: Colors.red)
      );
    }
    else return Text("");
  }
}
