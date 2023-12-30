import 'package:flutter/material.dart';

class NumberPlatesInfoProvider extends ChangeNotifier{
  int _cantidad = 1;

  int get cantidad => _cantidad;

  set cantidad(int value){
    _cantidad = value;
    notifyListeners();
  }

  void addCounter(){
    _cantidad ++;
    notifyListeners();
  }

  void subtractCounter(){
    if(_cantidad <= 1) return;
    _cantidad --;
    notifyListeners();
  }

  void resetCounter(){
    _cantidad = 1;
    notifyListeners();
  }

}