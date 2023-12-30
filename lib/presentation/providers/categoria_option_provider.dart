import 'package:flutter/material.dart';

class CategoriaOptionProvider extends ChangeNotifier{
  int _optionSelected = 0;

  //Getters
  int get optionSelected => _optionSelected;

  //Setters
  set optionSelected(int pos){
    _optionSelected = pos;
    notifyListeners();
  }

}