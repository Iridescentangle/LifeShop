import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart_provide.dart';
class DetailBottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvider>(
      builder:(context,child,provider){
        return  Container(
          width:ScreenUtil.instance.setWidth(750),
          height: ScreenUtil.instance.setHeight(80),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: (){},//TODO
                child:Container(
                  width: ScreenUtil.instance.setWidth(150),
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  var goodsInfo = provider.model.data.goodInfo;
                  Provide.value<CartProvider>(context).save(goodsInfo.goodsId, goodsInfo.goodsName, 1, goodsInfo.presentPrice, goodsInfo.image1);
                },//TODO
                child: Container(
                  color: Colors.orange,
                  width: ScreenUtil().setWidth(300),
                  alignment: Alignment.center,
                  child: Text(
                    '加入购物车',
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.instance.setSp(25),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  Provide.value<CartProvider>(context).remove();
                },//TODO
                child: Container(
                  color: Colors.redAccent,
                  width: ScreenUtil().setWidth(300),
                  alignment: Alignment.center,
                  child: Text(
                    '立即购买',
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil.instance.setSp(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}