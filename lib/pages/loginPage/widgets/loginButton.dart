
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/globalWidgets/loadingOverlay.dart';
import 'package:myfitnessmotivation/pages/loginPage/provider/accessHandler.dart';
import 'package:myfitnessmotivation/services/auth/authentication.dart';
import 'package:provider/provider.dart';


class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  LoginButton(this._formKey);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        color: Theme.of(context).accentColor,
        onPressed: () async {
          await _tryLogin(context);
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }

  ///tries to login user, if error, show error message,
  ///if successful show homePage
  _tryLogin(BuildContext context) async {

    try{
      await InternetAddress.lookup("example.com");
      if(_formKey.currentState.validate()){
        final accessHandler = Provider.of<AccessHandler>(context, listen: false);
        final auth = Provider.of<Authentication>(context, listen: false);
        Navigator.of(context).push(LoadingOverlay());
        auth.userSignIn(accessHandler.loginEmail, accessHandler.loginPassword)
            .then((value) {
          Navigator.of(context).pop();
          _showHomePage(accessHandler);
        }).catchError((error) async {
          Navigator.of(context).pop();
          _showErrorWarning(accessHandler);
        });
      }
    } on SocketException catch(_){
      _showSnackBar(context);
    }
  }
  _showSnackBar(BuildContext context){
    Flushbar(
      icon: Icon(Icons.warning, color: Colors.yellow,),
      message: "Du brauchst eine aktive Internetverbindung",
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
    )..show(context);
  }
  ///Show defined homePage when userSignIn was successful
  _showHomePage(AccessHandler accessHandler) {
    accessHandler.login();
    accessHandler.clear();
  }

  ///When userSignIn throws an exception, the [accessHandler] validationError will
  ///be set to true and another validate() call will show error messages on
  ///each TextFormField connected to the [_formKey]. After the validation() process
  ///completes the validation error will be set back to false to stop next validate() calls to always
  ///be false afterwards
  _showErrorWarning(AccessHandler accessHandler) {
    accessHandler.validationError();
    _formKey.currentState.validate();
    accessHandler.cancelValidationError();
  }
}