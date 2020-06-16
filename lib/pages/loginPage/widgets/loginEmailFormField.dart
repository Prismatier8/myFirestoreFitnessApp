import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/loginPage/provider/accessHandler.dart';
import 'package:provider/provider.dart';

class LoginEmailFormField extends StatefulWidget {
  final FocusNode focusNode;
  LoginEmailFormField({this.focusNode});
  @override
  _LoginEmailFormFieldState createState() => _LoginEmailFormFieldState();
}

class _LoginEmailFormFieldState extends State<LoginEmailFormField> {
  @override
  Widget build(BuildContext context) {
    final accessHandler = Provider.of<AccessHandler>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (email){
          accessHandler.setEmail(email);
        },
        onFieldSubmitted: (value){
          if(value.isNotEmpty){
            if(widget.focusNode != null){
              FocusScope.of(context).requestFocus(widget.focusNode);
            }
          }
        },
        validator: (email){
          if(email.isEmpty){
            return "Bitte E-Mail angeben";
          }
          if(accessHandler.validationFailed){
            return "E-Mail oder Passwort inkorrekt";
          }
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Theme.of(context).accentColor,
          ),
          labelText: "E-Mail",
        ),
      ),
    );
  }
}
