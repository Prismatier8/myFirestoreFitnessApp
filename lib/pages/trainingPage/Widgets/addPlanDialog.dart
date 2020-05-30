import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/dynamicTagWidget.dart';
import 'package:myfitnessmotivation/providerModel/formFieldValidationModel.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import '../../../globalWidgets/listenableTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/trainingPage/provider/tagSelectionModel.dart';
import 'package:provider/provider.dart';

class AddPlanDialog extends StatefulWidget {
  _AddPlanDialogState createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  final defaultBreakPause = 60;
  TextEditingController controller;
  final int selectedTagLimit = 3;
  bool isTitleMissing = false;
  final _formKey = GlobalKey<FormState>();
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
      content: SingleChildScrollView(
        child: Container(
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
              Form(
                key: _formKey,
                child: ListenableTextField(
                  type: TextFieldType.plan,
                  controller: controller,
                  isTitleMissing: isTitleMissing,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                  child: Text(
                    Names.BASIC_TAGS,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  DynamicTagWidget(
                    name: Names.TAGS_MONDAY,
                    color: Colors.lightBlueAccent,
                  ),
                  DynamicTagWidget(name: Names.TAGS_TUESDAY, color: Colors.green),
                  DynamicTagWidget(name: Names.TAGS_WEDNESDAY, color: Colors.orangeAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  DynamicTagWidget(name: Names.TAGS_THURSDAY, color: Colors.deepPurpleAccent),
                  DynamicTagWidget(name: Names.TAGS_FRIDAY, color: Colors.redAccent),
                  DynamicTagWidget(name: Names.TAGS_SATURDAY, color: Colors.pinkAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  DynamicTagWidget(name: Names.TAGS_SUNDAY, color: Colors.indigoAccent),
                  validateSelectedTagQuantity(tagSelectionModel) //returns error text
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ///CancelButton
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Provider.of<FormFieldValidationModel>(context, listen: false).clear(); ///clear state because adding process is over
            clearTagSelectionQuantity(tagSelectionModel); ///same reason like above
            Navigator.pop(context);
          },
          child: Text(
            Names.BASIC_CANCELBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
        ///AddButton
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            final val = Provider.of<FormFieldValidationModel>(context, listen: false);
            final planService = Provider.of<PlanService>(context, listen: false);
            val.planExist = await planService.validatePlanName(val.currentPlanName);

            if(_formKey.currentState.validate() && isSelectedTagsBelowLimit(tagSelectionModel)){

                addPlanToDB(tagSelectionModel);
                val.clear();
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
  ///Adds the plan to cloud Firestore.
  addPlanToDB(TagSelectionModel tags){
    final planService = Provider.of<PlanService>(context, listen: false);
     PlanModel plan = constructPlan(tags, planService);
     planService.addPlan(plan, plan.title);
  }
  PlanModel constructPlan(TagSelectionModel tags, PlanService planService){
    return PlanModel(
      title: controller.text,
      breakPause: defaultBreakPause,
      tags: tags.tagNamesList,
      exerciseRef: [],
      audioSignal: true,
      vibrationSignal: true,
    );
  }

  bool isSelectedTagsBelowLimit(TagSelectionModel tagSelectionModel) {
    return tagSelectionModel.currentSelectionQuantity <= selectedTagLimit;
  }

  bool checkMissingTitle() {
    return controller.text.isEmpty;
  }

  ///resets the current currentTagSelectionQuantity in TagSelectionQuantityModel to 0. The Counter has to reset when the user is leaving the AddPlanDialog.
  ///The counter will be 0 every time the user is trying to add a freshly new Plan
  clearTagSelectionQuantity(TagSelectionModel tagSelectionModel) {
    tagSelectionModel.clear();
  }
  ///Display ErrorText if selected tags exceeds tag limit
  Text validateSelectedTagQuantity(TagSelectionModel tagSelectionModel) {
    if (isSelectedTagsBelowLimit(tagSelectionModel)) {
      return Text("");
    }
    else return Text(Names.ADDPLAN_TAGERRORMESSAGE,
        style: TextStyle(color: Colors.red)
    );
  }
}
