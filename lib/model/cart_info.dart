import 'package:flutter/material.dart';
import 'dart:convert';
class CartInfo {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool isCheck;
  CartInfo({this.goodsId,this.goodsName,this.count,this.price,this.images,this.isCheck});
  CartInfo.fromJson(Map<String,dynamic> json){
    this.goodsId = json['goodsId'];
    this.goodsName = json['goodsName'];
    this.count = json['count'];
    this.price = json['price'];
    this.images = json['images'];
    this.isCheck = json['isCheck'];
  }
  Map<String,dynamic> toJson(){
    Map map = Map<String,dynamic>();
    map['goodsId'] = this.goodsId;
    map['goodsName'] = goodsName;
    map['count'] = count;
    map['price'] = price;
    map['images'] = images;
    map['isCheck'] = isCheck;
    return map;
  }
}