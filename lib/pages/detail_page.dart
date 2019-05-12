import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/detail_info_provide.dart';
import 'detail_page/detail_page_top_area.dart';
import 'detail_page/details_tabbar.dart';
import 'detail_page/detail_intro.dart';
import 'detail_page/detail_web.dart';
import 'detail_page/detail_bottom_navigator.dart';
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
            return Stack(children: <Widget>[
              ListView(
                children: <Widget>[
                    DetailTopArea(),
                    DetailIntro(),
                    DetailsTabbar(),
                    DetailWebPart(),
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  child: DetailBottomNavigator(),
                ),
              ]
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