
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/trainingPage/provider/tagSelectionModel.dart';
import 'package:provider/provider.dart';

class DynamicTagWidget extends StatefulWidget{
  final Color color;
  final String name;
  DynamicTagWidget({@required this.color, @required this.name});
  _DynamicTagWidgetState createState() => _DynamicTagWidgetState();
}
class _DynamicTagWidgetState extends State<DynamicTagWidget>{
  Color defaultColor = Colors.black45;
  Color selectedColor;
  bool isSelected = false;

  initState(){
    super.initState();
    selectedColor = widget.color;
  }
  Widget build(BuildContext context){
    TagSelectionModel tagSelectionModel = Provider.of<TagSelectionModel>(context, listen: false);

    return Container(
        height: 28,
        width: 80,
      child: Card(
        color: isSelected ? selectedColor : defaultColor,
        child: InkWell(
          onTap: (){
            setState(() {
              isSelected = !isSelected;
              if(isSelected == true){
                tagSelectionModel.increaseQuantity(widget.name);
              }
              else{
                tagSelectionModel.decreaseQuantity(widget.name);
              }
            });
          },
          child: Center(
              child: AutoSizeText(widget.name,
              style: TextStyle(color: Colors.white),),
          ),
        ),

      ),
    );
  }
}
