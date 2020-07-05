import 'package:flutter/material.dart';

class RegistrationValidator extends ChangeNotifier{

  String _currentEmail = "";
  String _currentPassword = "";
  bool _invalidEmail = false;
  bool _emailInUse = false;
  get currentEmail => _currentEmail;
  get currentPassword => _currentPassword;
  get isEmailInUse => _emailInUse;
  get isInvalidEmail => _invalidEmail;

  setEmail(String email){
    _currentEmail = email.trim();
  }
  setPassword(String password){
    _currentPassword = password;
  }
  setEmailValidation(bool isEmailInvalid){
    _invalidEmail = isEmailInvalid;
  }
  setEmailInUse(bool isEmailInUse){
    _emailInUse = isEmailInUse;
  }
  ///cleanse validator state to default values.
  ///Should normally be called when registration process is complete or canceled
  clear(){
    _currentEmail = "";
    _currentPassword = "";
    _invalidEmail = false;
    _emailInUse = false;
  }
}