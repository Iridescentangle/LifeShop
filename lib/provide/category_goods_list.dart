import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import '../model/category_goods_list.dart';
class CategoryGoodsListProvider with ChangeNotifier{
  List<CategoryGoodsModel> list = [];
  setGoodsList(List<CategoryGoodsModel> newList){
    list =newList;
    notifyListeners();
  }
}