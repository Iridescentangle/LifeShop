import 'package:flutter/material.dart';
import '../../provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
class CartBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil.instance.setWidth(750),
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _checkAllButton(context),
            _totalPrice(context),
            _settleCart(context),
          ],
        ),
    );
  }
  Widget _checkAllButton(BuildContext context){
    return Container(
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Provide<CartProvider>(
            builder:(context,child,provider){
              return Checkbox(
                value: provider.isAllSelected,
                activeColor: Colors.blueAccent,
                onChanged: (value){
                  Provide.value<CartProvider>(context).changeAllSelect(value);
                },
              );
            }
          ),
          Text('全选'),
        ],
      ),
    );
  }
  Widget _totalPrice(BuildContext context){
    return Container(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0
      ),
      width: ScreenUtil.instance.setWidth(450),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil.instance.setWidth(280),
                child: Text('合计: ',style:TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenUtil.instance.setSp(33),
                )),
              ),
              Provide<CartProvider>(
                builder:(context,child,provider){
                  return Container(
                    width: ScreenUtil.instance.setWidth(170),
                    child: Text(
                      '￥${provider.totalPrice}',
                      style:TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil.instance.setSp(33),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
          Text('满10元免配送费，预购免配送费',style:TextStyle(color:Colors.black,fontSize: ScreenUtil.instance.setSp(23))),
        ],
      ),
    );
  }
  Widget _settleCart(BuildContext context){
    return InkWell(
      onTap: (){
        //TODO 结算
      },
      child:Provide<CartProvider>(
        builder: (context,child,provider){
          return Container(
            alignment: Alignment.center,
            width: ScreenUtil.instance.setWidth(150),
            padding: EdgeInsets.only(top: 15,bottom: 15),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            child:Text(
              '结算(${provider.totalCount})',
              style:TextStyle(color: Colors.white,fontSize: ScreenUtil.instance.setSp(25))
            ),
          );
        }
      ),
    );
  }
}