import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info_provide.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    getGoodsDetailInfo(context);
    return Container(
      child:Text('商品ID为：${goodsId}')
      
    );
  }
  void getGoodsDetailInfo(context){
    Provide.value<GoodsDetailProvider>(context).getGoodsDetail(goodsId);
  }
}