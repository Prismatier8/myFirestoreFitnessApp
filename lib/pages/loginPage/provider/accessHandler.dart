import 'package:flutter/material.dart';

///The AccessHandler is a class to collect User input data from the loginPage and provides it for the loginButton Widget that is responsible
///for accessing the home page
class AccessHandler extends ChangeNotifier{

  VoidCallback _logout;
  VoidCallback _login;
  String _uid; ///currently logged in user ID, which is null if the developer uses hot restart feature
  ///Better use getCurrentUser() in [Authentication] to be safe or find other solutions

  String _currentLoginEmail = "";
  String _currentLoginPassword = "";
  bool _validationFailed = false;

  get uid => _uid;
  get validationFailed => _validationFailed;
  get loginEmail => _currentLoginEmail;
  get loginPassword => _currentLoginPassword;

  ///Sets callbacks for login and logout operations from the rootPage.
  ///The rootPage decides if loginPage or user dependent homePage should be loaded.
  ///Do not call this method outside of rootPage
  initCallbacks(VoidCallback login, VoidCallback logout){
    _login = login;
    _logout = logout;
  }
  ///Sets validationError to true. This method is used for the login process
  validationError(){
    _validationFailed = true;
  }
  ///sets validationError back to false (default State). This method is used
  ///for the login process
  cancelValidationError(){
    _validationFailed = false;
  }
  setEmail(String email){
    email = email.trim();
    _currentLoginEmail = email;
  }
  setPassword(String password){
    _currentLoginPassword = password;
  }
  ///sets user ID, this method is called from logout and login Callback function
  ///inside rootPage. Each login() and logout() call will set user ID to _uid
  setUID(String uid){
    _uid = uid;
  }
  ///forces logged in user to log out and show loginPage
  logout(){
    _logout.call();
  }
  ///shows entryPage, calling this method does not login the user, it will only
  ///show the defined entryPage. Make sure, that the user is successfully logged
  ///in when calling this method
  login(){
    _login.call();
  }
  ///Wipe login info state. Usually called when user successfully
  ///accessed App
  clear(){
    _currentLoginEmail = "";
    _currentLoginPassword = "";
    _validationFailed = false;
  }

}