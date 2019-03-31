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
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
    _getGoodsList();
  }

  void _getGoodsList({String categoryId}) async{
    var data = {
      'categoryId':categoryId == null ?'4':categoryId,
      'categorySubId':'',
      'page':1
    };
    request('getMallGoods',formData: data).then((result){
       CategoryGoodsOuterModel outModel = CategoryGoodsOuterModel.fromJson(json.decode(result));
        Provide.value<CategoryGoodsListProvider>(context).setGoodsList(outModel.data);
    });
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
       Provide.value<ChildCategory>(context).setChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
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
        String mallCategoryId = list[index].mallCategoryId;
        _getGoodsList(categoryId: mallCategoryId);
        Provide.value<ChildCategory>(context).setChildCategory(childList,mallCategoryId);
        
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
                return _rightInkWell(index,childCategory.childCategoryList[index]);
              },
            ),
          );
      }
    );
  }
  void _getGoodsList(String categorySubId){
    var data = {
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };
    request('getMallGoods',formData: data).then((result){
       CategoryGoodsOuterModel outModel = CategoryGoodsOuterModel.fromJson(json.decode(result));
       if(outModel.data != null){
        Provide.value<CategoryGoodsListProvider>(context).setGoodsList(outModel.data);
       }else{
         Provide.value<CategoryGoodsListProvider>(context).setGoodsList([]);
       }
    });
  }
  Widget _rightInkWell(int index,BxMallSubDto item){
    bool isClick = false;
    isClick = index == Provide.value<ChildCategory>(context).childIndex ;
    return InkWell(
      onTap: (){
       Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
       _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(item.mallSubName,style:TextStyle(color:isClick?Colors.lightBlue:Colors.black87,fontSize:ScreenUtil.instance.setSp(25)),),
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
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvider>(
      builder: (context,child,vider){
        if(vider.list.length == 0){
          return Center(
            child: Text('暂时没有该类商品哦!'),
          );
        }
          return Container(
            width: ScreenUtil.instance.setWidth(570),
            height: ScreenUtil.instance.setHeight(1000),
            child: Provide<CategoryListStyleProvider>(
              builder: (context,child,provider){
                return Container(
                    child:provider.style==CategoryListStyle.List?
                    Container(
                        width: ScreenUtil.instance.setWidth(570),
                        child:ListView.builder(
                          itemCount: vider.list.length,
                          itemBuilder: (context,index){
                            return _buildListItem(vider.list[index]);
                          },
                        ),
                      )
                    :
                    SingleChildScrollView(
                      child:Wrap(
                        // spacing: 2,
                        children: vider.list.map((item){
                            return _buildGridItem(item);
                          }
                        ).toList(),
                      ),
                    ),
                );
              },
            ),
          );
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
  Widget _buildListItem(CategoryGoodsModel item){
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
            _listGoodImage(item.image),
            Column(
              children: <Widget>[
                _girdGoodsName(item.goodsName),
                _goodsPrice(item.oriPrice,item.presentPrice),
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
  Widget _goodsPrice(oriPrice,prePrice){
    return  Container( 
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(370),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text(
              '价格:￥${prePrice}',
              style: TextStyle(color:Colors.black,),
              ),
            Text(
              '￥${oriPrice}',
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