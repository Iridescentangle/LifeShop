import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引
  String categoryId = '4';//大类的id
  List<BxMallSubDto> 
  setChildCategory(List<BxMallSubDto> list,String id){
    BxMallSubDto allCategory =BxMallSubDto();
    categoryId = id;
    allCategory.mallSubId = '00';
    allCategory.mallCategoryId = '00';
    allCategory.comments = 'null';
    allCategory.mallSubName = '全部';
    childCategoryList = [allCategory];
    childCategoryList.addAll(list);
    notifyListeners();
  }
  changeChildIndex(int newIndex){
    childIndex =newIndex;
    notifyListeners();
  }
  

}