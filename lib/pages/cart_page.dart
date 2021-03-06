import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/provide.dart';
import '../provide/cart_provide.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom_bar.dart';
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('购物车'),centerTitle: true,),
      body: FutureBuilder(
        future: _getCartGoods(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Stack(
              children:<Widget>[
                Provide<CartProvider>(
                  builder:(context,child,provider){
                  return Positioned(
                    top: 0,
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child:ListView.builder(
                          itemCount: provider.data.length,
                          itemBuilder: (context,index){
                            return CartItemView(provider.data[index]);
                          },
                      ),
                    );
                  }
                ),
                Positioned(
                    bottom: 0,
                    child: CartBottomBar(),
                  ),
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  Future _getCartGoods(context) async{
    await Provide.value<CartProvider>(context).getCartGoods();
    return 'Finished';
  }
}