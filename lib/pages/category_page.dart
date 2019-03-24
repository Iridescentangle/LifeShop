import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../model/category_goods_list.dart';
import '../provide/category_list_style.dart';
class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String text = '';
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),centerTitle: true,actions: <Widget>[
        Provide<CategoryListStyleProvider>(
          builder: (context,child,provider){
            return IconButton(
              onPressed: (){
                Provide.value<CategoryListStyleProvider>(context).changeStyle();
              },
              icon: Icon(provider.style ==CategoryListStyle.List?Icons.grid_on:Icons.list),
            );
          },
        ),
        
        
      ],),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNavigator(),
            Column(
              children: <Widget>[
                RightCategoryNavigator(),
                GoodsList(),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
class LeftCategoryNavigator extends StatefulWidget {
  @override
  _LeftCategoryNavigatorState createState() => _LeftCategoryNavigatorState();
}

class _LeftCategoryNavigatorState extends State<LeftCategoryNavigator> {
  var leftIndex = 0;
   List list = [];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.instance.setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
      ),
    );
  }
  void _getCategory() async{
    await request('category').then((result){
      var data = json.decode(result.toString());
      CategoryModel model =CategoryModel.fromJson(data);
      setState(() {
        list = model.data;
      });
       Provide.value<ChildCategory>(context).setChildCategory(list[0].bxMallSubDto);
    });
  }
  Widget _leftInkWell(int index) {
    bool isChecked = false;
    isChecked = (index ==leftIndex);
    return InkWell(
      onTap: (){
        setState(() {
         leftIndex =index; 
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).setChildCategory(childList);
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil.instance.setHeight(100),
        decoration: BoxDecoration(
          color: isChecked?Color.fromRGBO(236, 236, 236, 1.0):Colors.white,
          border: Border(
            bottom:BorderSide(width: 1,color: Colors.black12),
          ),
        ),
        child: Text(list[index].mallCategoryName,),
      ),
    );
  }
}
class RightCategoryNavigator extends StatefulWidget {
  @override
  _RightCategoryNavigatorState createState() => _RightCategoryNavigatorState();
}

class _RightCategoryNavigatorState extends State<RightCategoryNavigator> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
         return  Container(
            decoration: BoxDecoration(color: Colors.white,border: Border(
              bottom: BorderSide(width: 1.0,color: Colors.grey.shade300)
            )),
            alignment: Alignment.center,
            height: ScreenUtil.instance.setHeight(80),
            width: ScreenUtil.instance.setWidth(570),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context,index){
                return _rightInkWell(childCategory.childCategoryList[index].mallSubName);
              },
            ),
          );
      }
    );
  }
  Widget _rightInkWell(String title){
    return InkWell(
      onTap: (){
       
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(title,style:TextStyle(color:Colors.black87,fontSize:ScreenUtil.instance.setSp(25)),),
      ),
    );
  }
}
//商品列表
class GoodsList extends StatefulWidget {
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {
  List<CategoryGoodsModel> list = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: request('getMallGoods',formData:{'categoryId':'4','CategorySubId':'','page':1}),
      builder: (context,snapshot){
        if(snapshot.hasData){
          CategoryGoodsOuterModel outModel = CategoryGoodsOuterModel.fromJson(json.decode(snapshot.data));
          list =outModel.data; 
          return Container(
            width: ScreenUtil.instance.setWidth(570),
            height: ScreenUtil.instance.setHeight(1000),
            child: Provide<CategoryListStyleProvider>(
              builder: (context,child,provider){
                return Container(
                  child:provider.style==CategoryListStyle.List?
                  ListView.builder(
                    itemCount: list.length,
                    itemBuilder: _buildListItem,
                  )
                  :
                  SingleChildScrollView(
                    child:Wrap(
                      // spacing: 2,
                      children: list.map((item){
                          return _buildGridItem(item);
                        }
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Widget _buildGridItem(CategoryGoodsModel item){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0,color: Colors.black12)
        ),
      width: ScreenUtil.instance.setWidth(275),
      height: ScreenUtil.instance.setHeight(375),
      child: InkWell(
        onTap: (){

        },
        child: Column(
          children: <Widget>[
            _gridGoodsImage(item.image),
            _girdGoodsName(item.goodsName),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _gridGoodsPrePrice(item.presentPrice),
                _gridGoodsOriPrice(item.oriPrice),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _gridGoodsPrePrice( prePrice){
    return Text(
      '￥${prePrice}    ',
      style: TextStyle(
        color: Colors.black,

      ),
    );
  }
  Widget _gridGoodsOriPrice( oriPrice){
    return Text(
      '￥${oriPrice}',
      style: TextStyle(
        color: Colors.black26,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }
  Widget _buildListItem(context,index){
    return InkWell(
      onTap: (){

      },
      child:Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _listGoodImage(list[index].image),
            Column(
              children: <Widget>[
                _girdGoodsName(list[index].goodsName),
                _goodsPrice(index),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _listGoodImage(String url){
    return Container(
      width: ScreenUtil.instance.setWidth(200),
      child: Image.network(url),
    );
  }
  Future _getGoodsList() async{
    var data = {
      'categoryId':'4',
      'CategorySubId':'',
      'page':1
    };
    return request('getMallGoods',formData: data);
  }
  Widget _gridGoodsImage(String url){
    return Container(
      width: ScreenUtil.instance.setWidth(275),
      child: Image.network(url),
    );
  }
  Widget _goodsPrice(index){
    return  Container( 
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text(
              '价格:￥${list[index].presentPrice}',
              style: TextStyle(color:Colors.black,),
              ),
            Text(
              '￥${list[index].oriPrice}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
            )
        ]
      )
    );
  }
  Widget _girdGoodsName(String name){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil.instance.setWidth(275),
      child: Text(
        name,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil.instance.setSp(22),
          color: Colors.lightBlue,
          ),
        ),
    );
  }
}