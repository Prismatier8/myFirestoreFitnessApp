import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/registrationPage/provider/registrationValidator.dart';
import 'package:myfitnessmotivation/pages/registrationPage/widgets/accountExistText.dart';
import 'package:myfitnessmotivation/pages/registrationPage/widgets/regConfirmedPasswordFormField.dart';
import 'package:myfitnessmotivation/pages/registrationPage/widgets/regEmailFormField.dart';
import 'package:myfitnessmotivation/pages/registrationPage/widgets/regPasswordFormField.dart';
import 'package:myfitnessmotivation/pages/registrationPage/widgets/registrationButton.dart';
import 'package:provider/provider.dart';

enum _PasswordType {password, confirmedPassword}
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final double positionedDistance = 80;
  FocusNode _nodeUser;
  FocusNode _nodeEmail;
  FocusNode _nodePassword;
  bool _hidePassword;
  bool _hideConfirmedPassword;
  @override
  void initState() {
    _nodeUser = FocusNode();
    _nodeEmail = FocusNode();
    _nodePassword = FocusNode();
    _hidePassword = true;
    _hideConfirmedPassword = true;
    super.initState();
  }

  @override
  void dispose() {
    _nodeUser.dispose();
    _nodeEmail.dispose();
    _nodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double safeArea = MediaQuery.of(context).padding.top;
    return ChangeNotifierProvider(
      create: (context) => RegistrationValidator(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              Container(
                height: safeArea,
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Stack(
                      children: <Widget>[

                        Positioned(
                          top: positionedDistance,
                          child: EmailFormField(
                            focusNodeUser: _nodeUser,
                            focusNodeEmail: _nodeEmail,),
                        ),
                        Positioned(
                          top: positionedDistance * 2,
                          child: PassWordFormField(
                            focusNodeEmail: _nodeEmail,
                            focusNodePassword: _nodePassword,
                            hidePassword: _hidePassword,
                          ),
                        ),
                        Positioned(
                          top: positionedDistance * 3,
                          child: ConfirmedPasswordFormField(
                            hidePassword: _hideConfirmedPassword,
                            focusNode: _nodePassword,
                          ),
                        ),
                        Positioned(
                          top: positionedDistance * 2.1,
                          right: 19,
                          child: _passwordHideDisplay(_PasswordType.password),
                        ),
                        Positioned(
                          top: positionedDistance * 3.1,
                          right: 19,
                          child: _passwordHideDisplay(
                              _PasswordType.confirmedPassword),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height - safeArea) * 0.05,
              ),
              RegistrationButton(_formKey),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: AccountExistText(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordHideDisplay(_PasswordType type) {
    return IconButton(
        iconSize: 20,
        onPressed: () {
          setState(() {
            if(type == _PasswordType.password){
              _hidePassword = !_hidePassword;
            } else {
              _hideConfirmedPassword = !_hideConfirmedPassword;
            }
          });
        },
        icon: _getIcon(type)
    );
  }
  Icon _getIcon(_PasswordType type){

    if(type == _PasswordType.password){
      return Icon(
          Icons.remove_red_eye,
          color: _hidePassword ? Colors.black38 : Theme.of(context).accentColor);
    } else {
      return Icon(
          Icons.remove_red_eye,
          color: _hideConfirmedPassword ? Colors.black38 : Theme.of(context).accentColor);
    }
  }

}
