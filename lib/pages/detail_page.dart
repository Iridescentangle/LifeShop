import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info_provide.dart';
import 'detail_page/detail_page_top_area.dart';
import 'detail_page/details_tabbar.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    getGoodsDetailInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()=>Navigator.pop(context),
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: getGoodsDetailInfo(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                DetailTopArea(),
                DetailsTabbar(),
              ],
            );
          }else{
            return Center(child: Text('暂无数据哦!'),);
          }
        },
      ),
    );
  }
  Future getGoodsDetailInfo(context) async{
    await Provide.value<GoodsDetailProvider>(context).getGoodsDetail(goodsId);
    return '获取数据成功';
  }
  }