import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../model/category_goods_list.dart';
class CategoryGoodsListProvider with ChangeNotifier{
  List<CategoryGoodsModel> list = [];
  setMoreGoodsList(List<CategoryGoodsModel> newList){
    list.addAll(newList);
    notifyListeners();
  }
  setGoodsList(List<CategoryGoodsModel> newList){
    list = newList;
    notifyListeners();
  }
}