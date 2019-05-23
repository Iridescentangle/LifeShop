import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import '../model/cart_info.dart';
class CartProvider with ChangeNotifier{
  String cartTag = 'cartInfo';
  List<CartInfo> data = [];
  String cartString = '[]';
  double totalPrice = 0.00;
  int totalCount = 0;
  bool isAllSelected = false;
  void save(goodsId,goodsName,count,price,images,isCheck) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //从SP中获取购物车信息
     cartString = sp.getString(cartTag);
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
      CartInfo cartInfo = CartInfo(goodsId: goodsId,goodsName: goodsName,count: count,price: price,images: images,isCheck: isCheck);
      data.add(cartInfo);
      tempList.add(cartInfo.toJson());
    }
    String finalData = json.encode(tempList).toString();
    sp.setString(cartTag, finalData);
    await getCartGoods();
    notifyListeners();
  }
  void remove() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(cartTag);
    data.clear();
    notifyListeners();
  }
  getCartGoods() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartTag);
    data.clear();
    totalPrice = 0;
    totalCount = 0;
    isAllSelected = true;//默认是全选中的，对商品遍历后如果有未选中商品再行更改
    if(cartString != null && cartString != ''){
      List temp = (json.decode(cartString.toString()) as List).cast();
      temp.forEach((item){
        data.add(CartInfo.fromJson(item));
        if(item['isCheck']){
          //被选中 需要计算价格
          totalCount += item['count'];
          totalPrice  += item['price'] * item['count'];
        }else{
          //只要有一个未被选中 就不是全选
          isAllSelected = false;
        }
      });
    }
    notifyListeners();
  }
  deleteGoods(goodsId) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartTag);
    var temp = cartString == null ?
    []:
    json.decode(cartString.toString());
    List tempList = (temp as List).cast();
    int index = -1;
    for(int i = 0; i < tempList.length; i ++){
      if(tempList[i]['goodsId'] == goodsId){
        //说明是要删除的商品
        //1.删除临时获得列表中的数据
        index = i;
      }
    }
    if(index != -1){
      //说明存在需要删除的内容
      tempList.removeAt(index);
    }
    //2.持久化数据
    String result = json.encode(tempList).toString();
    sp.setString(cartTag,result);
    await getCartGoods();
    // notifyListeners();
  }
  changeSelectState(CartInfo item) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(cartTag);
    var temp = cartString == null?
    []:
    json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    int index = -1;
    for(int i = 0;i < tempList.length;i ++){
      if(tempList[i]['goodsId'] == item.goodsId){
        //说明即是要更改的
        index = i;
      }
    }
    if(index != -1){
      tempList[index] = item.toJson();
    }
    String result = json.encode(tempList).toString();
    sp.setString(cartTag, result);
    await getCartGoods();
  }
  changeAllSelect(bool allSelected) async{
    isAllSelected = allSelected;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String cartString = sp.getString(cartTag);
    var temp = cartString == null?
    []:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    List newList = [];
    for(var item in tempList){
      var newItem = item;//先复制变量
      newItem['isCheck'] = allSelected;
      newList.add(newItem);
    }
    //完成遍历后存储
    String result = json.encode(newList).toString();
    sp.setString(cartTag,result);
    getCartGoods();
  }
  addOrMinusGoodsCount(CartInfo goodsItem,bool addOrMinus) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String cartString = sp.getString(cartTag).toString();
    List<Map> tempList = cartString == null? [] :(json.decode(cartString) as List).cast();
    int index = -1;
    for(int i = 0;i < tempList.length;i++){
      if(tempList[i]['goodsId'] == goodsItem.goodsId){
        //说明是要修改数量的商品
        index = i;
      }
    }
    if(index != -1){
      if(addOrMinus){
        tempList[index]['count'] += 1;
      }else{
        tempList[index]['count'] -= 1;
      }
    }
    String result = json.encode(tempList).toString();
    sp.setString(cartTag, result);
    await getCartGoods();
  }
}