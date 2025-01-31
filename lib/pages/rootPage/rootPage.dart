import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/entryPage.dart';
import 'package:myfitnessmotivation/pages/loginPage/loginPage.dart';
import 'package:myfitnessmotivation/pages/loginPage/provider/accessHandler.dart';
import 'package:myfitnessmotivation/services/auth/authentication.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String _userID = "";
  AuthStatus _currentStatus = AuthStatus.NOT_LOGGED_IN;
  Authentication _auth;
  AccessHandler _accessHandler;
  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Authentication>(context, listen: false);
    _accessHandler = Provider.of<AccessHandler>(context, listen: false);
    initiateCallbacks();
    _auth.getCurrentUser().then((user) {
      setState(() {
        if(user != null){
          _userID = user?.uid;
        }
        _currentStatus = user?.uid == null
            ? AuthStatus.NOT_LOGGED_IN
            : AuthStatus.LOGGED_IN;
      });
    });
  }
  initiateCallbacks(){
    _accessHandler.initCallbacks(loginCallback, logoutCallback);
  }
  void loginCallback(){
    _auth.getCurrentUser().then((user) {
      setState(() {
        _userID = user.uid;
        _accessHandler.setUID(_userID);
      });
    });
    setState(() {
      _currentStatus = AuthStatus.LOGGED_IN;
    });
  }
  void logoutCallback() {
    setState(() {
      _currentStatus = AuthStatus.NOT_LOGGED_IN;
      _userID = "";
      _accessHandler.setUID(_userID);
      _auth.userSignOut();
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_currentStatus == AuthStatus.WAITING){
      return _getLoadingIndicator();
    } else if(_currentStatus == AuthStatus.NOT_LOGGED_IN){
      return LoginPage();
    } else if (_currentStatus == AuthStatus.LOGGED_IN){
      if(_userID.length > 0 && _userID != null){
        print(_userID);
        return EntryPage();
      } else {
        return _getLoadingIndicator();
      }
    } else return _getLoadingIndicator();
  }

  Widget _getLoadingIndicator(){
    return Container(
      alignment: Alignment.bottomCenter,
      child: CircularProgressIndicator(),
    );
  }
}