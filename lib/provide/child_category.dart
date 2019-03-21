import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  List<BxMallSubDto> 
  setChildCategory(List<BxMallSubDto> list){
    BxMallSubDto allCategory =BxMallSubDto();
    allCategory.mallSubId = '00';
    allCategory.mallCategoryId = '00';
    allCategory.comments = 'null';
    allCategory.mallSubName = '全部';
    childCategoryList = [allCategory];
    childCategoryList.addAll(list);
    notifyListeners();
  }
  

}