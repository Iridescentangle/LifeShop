import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
enum CategoryListStyle{
  Grid,List
}
class CategoryListStyleProvider with ChangeNotifier{
  CategoryListStyle style = CategoryListStyle.List;
  changeStyle(){
    if(style ==CategoryListStyle.Grid){
      style =CategoryListStyle.List;
    }else{
      style =CategoryListStyle.Grid;
    }
    notifyListeners();
  }
  setStyle(CategoryListStyle newStyle){
    style = newStyle;
    notifyListeners();
  }
}