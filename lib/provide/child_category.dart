import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  setChildCategory(List list){
    childCategoryList = list;
    notifyListeners();
  }
  

}