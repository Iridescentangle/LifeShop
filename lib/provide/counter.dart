import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int count = 0;
  increment(){
    count ++;
    notifyListeners();
  }
  decrement(){
    count--;
    notifyListeners();
  }
}