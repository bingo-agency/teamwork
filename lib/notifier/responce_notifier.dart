import 'package:flutter/material.dart';
class responcenotifier extends ChangeNotifier{
  String _responseWindowText ='';
  String get responseWindowText =>_responseWindowText;
  void updateResponceWindowText(responseWindowText){
    _responseWindowText= responseWindowText;
    notifyListeners();
  }
}