import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import '../model/cart_info.dart';
class CartProvider with ChangeNotifier{
  List<CartInfo> data = [];
  String cartString = '[]';
  void save(goodsId,goodsName,count,price,images) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //从SP中获取购物车信息
     cartString = sp.getString('cartInfo');
    //转为List
    var temp = cartString == null?
    [] :
    json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    int countValue = 0;
    bool hasExisted = false;
    //对列表进行遍历 判断是否存在要加入的商品
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        //说明购物车中已存在该商品
        tempList[countValue]['count'] = item['count'] + 1;
        data[countValue].count += 1;
        hasExisted = true;
      }
      countValue ++;
    });
    if(!hasExisted){
      //购物车中不存在，需要添加
      CartInfo cartInfo = CartInfo(goodsId: goodsId,goodsName: goodsName,count: count,price: price,images: images);
      data.add(cartInfo);
      tempList.add(cartInfo.toJson());
    }
    String finalData = json.encode(tempList).toString();
    sp.setString('cartInfo', finalData);
    // notifyListeners();
  }
  void remove() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');
    data.clear();
    notifyListeners();
  }
  getCartGoods() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    data.clear();
    if(cartString != null && cartString != ''){
      List temp = (json.decode(cartString.toString()) as List).cast();
      temp.forEach((item){
        data.add(CartInfo.fromJson(item));
      });
    }
    notifyListeners();
  }
}