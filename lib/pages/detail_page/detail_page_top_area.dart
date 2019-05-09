import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_shop/provide/detail_info_provide.dart';
import 'package:provide/provide.dart';
class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvider>(
      builder: (context,child,val){
        var goodInfo = Provide.value<GoodsDetailProvider>(context).model.data.goodInfo;
        if(goodInfo != null){
          return Container(
            color: Colors.white,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                      _goodsDetailImage( goodInfo.image1),
                      _goodsName( goodInfo.goodsName ),  
                      _goodsNum(goodInfo.goodsSerialNumber),
                      _goodsPrice(goodInfo.presentPrice,goodInfo.oriPrice)
                  ],
                ),
          );
        }else{
          return Center(
            child: Text('加载数据中...'),
          );
        }
      },
      
    );
  }
  //商品图片
  Widget _goodsDetailImage(String imgUrl){
    return  Image.network(imgUrl,
    width:ScreenUtil.instance.setWidth(750));
  }
  //商品名称
  Widget _goodsName(name){
      return Container(
        width: ScreenUtil().setWidth(730),
        padding: EdgeInsets.only(left:15.0),
        child: Text(
          name,
          maxLines: 1,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
      );
  }
   Widget _goodsNum(num){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(
          color: Colors.black26
        ),
      ),
      
    );
  }
  Widget _goodsPrice(presentPrice,originalPrice){
    return Container(
      width: ScreenUtil.instance.setWidth(750),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(40.0),
              color: Colors.blueAccent,
            ),
            ),
          Text(
            '市场价:￥${originalPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}