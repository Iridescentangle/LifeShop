import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../model/goods_detail.dart';
import '../service/service_method.dart';
import 'dart:convert';
class GoodsDetailProvider with ChangeNotifier{
  GoodsOutModel model;
  bool leftSelected = true;
  void getGoodsDetail(String goodsId){
    var formData = {'goodId':goodsId};
    request('getGoodDetailById',formData: formData).then((result){
      model = GoodsOutModel.fromJson(json.decode(result));
      notifyListeners();
    });
  }
  void changeTab(){
    leftSelected = !leftSelected;
    notifyListeners();
  }
}
