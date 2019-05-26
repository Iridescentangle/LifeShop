import 'package:flutter/material.dart';
import 'package:life_shop/provide/main_bottom_provider.dart';
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
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      //跳转到购物车页面
                      Provide.value<MainBottomProvider>(context).changeCurrentIndex(2);
                      Navigator.pop(context);
                    },
                    child:Stack(
                      children:<Widget>[
                        Container(
                          width: ScreenUtil.instance.setWidth(150),
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Provide<CartProvider>(
                          builder:(context,child,provider){
                            return Positioned(
                              right: 10,
                              top: 5,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${provider.totalCount}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil.instance.setSp(16)),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async{
                  var goodsInfo = provider.model.data.goodInfo;
                  Provide.value<CartProvider>(context).save(goodsInfo.goodsId, goodsInfo.goodsName, 1, goodsInfo.presentPrice, goodsInfo.image1,true);
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