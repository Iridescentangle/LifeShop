import 'package:flutter/material.dart';
import '../../provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_info.dart';
import 'package:provide/provide.dart';
class CartGoodsCountManager extends StatelessWidget {
  final CartInfo cartInfo;
  CartGoodsCountManager(this.cartInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.instance.setWidth(150),
      height: ScreenUtil.instance.setHeight(50),
      margin: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          _addOrMinusWidget(context,false, this.cartInfo.count > 1),
          _goodsCount(this.cartInfo.count),
          _addOrMinusWidget(context,true, true),
        ],
      ),
    );
  }
  Widget _addOrMinusWidget(BuildContext context,bool addOrMinus,bool enable){
    return InkWell(
      onTap: (){
        if(addOrMinus){
          //增加
          Provide.value<CartProvider>(context).save(cartInfo.goodsId, cartInfo.goodsName, cartInfo.count, cartInfo.price, cartInfo.images, cartInfo.isCheck);
        }else{
          Provide.value<CartProvider>(context).deleteGoods(cartInfo.goodsId);
        }
      },
      child:enable?
      Container(
        alignment: Alignment.center,
        width: ScreenUtil.instance.setWidth(50),
        height: ScreenUtil.instance.setHeight(50),
        decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
          ),
        child:Text(
          addOrMinus?'+':'-',
          style:TextStyle(
            color: enable?Colors.black:Colors.grey,
            fontSize: ScreenUtil.instance.setSp(35),
          ),
        ),
      ):
      Container(
        width: ScreenUtil.instance.setWidth(50),
        color: Colors.grey.shade100,
      ),
    );
  }
  Widget _goodsCount(int count){
    return Container(
      alignment:Alignment.center,
      width: ScreenUtil.instance.setWidth(50),
      height: ScreenUtil.instance.setHeight(50),
      color: Colors.white,
      child: Text(
        '${count}',
        style:TextStyle(
          fontSize: ScreenUtil.instance.setSp(25),
          color: Colors.black87,
        )
      ),
    );
  }
}