import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/loginPage/provider/accessHandler.dart';
import 'package:provider/provider.dart';


class LoginPasswordFormField extends StatefulWidget {
  final FocusNode focusNode;
  LoginPasswordFormField({this.focusNode});
  @override
  _LoginPasswordFormFieldState createState() => _LoginPasswordFormFieldState();
}

class _LoginPasswordFormFieldState extends State<LoginPasswordFormField> {

  @override
  Widget build(BuildContext context) {
    final accessHandler = Provider.of<AccessHandler>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        focusNode: widget.focusNode,
        onChanged: (password){
          accessHandler.setPassword(password);
        },
        validator: (password){
          if(password.isEmpty){
            return "Bitte ein Passwort angeben";
          }
          if(accessHandler.validationFailed){
            return "E-Mail oder Passwort inkorrekt";
          }
          return null;
        },
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).accentColor,
          ),
          labelText: "Passwort",
        ),
      ),
    );
  }
}
