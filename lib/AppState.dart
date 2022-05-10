import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  AppState();

  String hometitle = "";
  bool login= true;

  void setDisplayText(String text) {
    print('till this is working !');



    if (login=false){
      hometitle="Find the perfect value of your Property Exchange";
    }
    else if(login=true)
    {
      hometitle="Hello User";

    }
    notifyListeners();
  }


  String get getDisplayText => hometitle;
}