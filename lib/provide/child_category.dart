import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引
  String categoryId = '4';//大类的id
  String categorySubId = '';//小类id
  int page = 1;//商品列表当前页数
  String noMoreText = '';//显示没有更多数据的提示文字
  List<BxMallSubDto> 
  setChildCategory(List<BxMallSubDto> list,String id){
    BxMallSubDto allCategory =BxMallSubDto();
    categoryId = id;
    allCategory.mallSubId = '';
    allCategory.mallCategoryId = '00';
    allCategory.comments = 'null';
    //点击大类和小类的时候 页码都要重置
    page = 1;
    noMoreText = '';
    allCategory.mallSubName = '全部';
    childCategoryList = [allCategory];
    childCategoryList.addAll(list);
    notifyListeners();
  }
  changeChildIndex(int newIndex,String subId){
    page = 1;
    noMoreText = '';
    childIndex =newIndex;
    categorySubId = subId;
    notifyListeners();
  }
  addPage(){
    page ++;
    notifyListeners();
  }
  changeNoMoreText(String text){
    noMoreText = text;
    notifyListeners();
  }
}