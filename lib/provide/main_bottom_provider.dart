import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
class MainBottomProvider with ChangeNotifier{
  int currentIndex = 0;
  changeCurrentIndex(int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }
}