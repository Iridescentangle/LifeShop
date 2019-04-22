import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('商品ID为：${goodsId}')
      
    );
  }
}