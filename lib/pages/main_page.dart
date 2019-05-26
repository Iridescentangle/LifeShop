import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/main_bottom_provider.dart';
import 'package:provide/provide.dart';
class MainPage extends StatelessWidget {
    final List<Widget> pages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart,),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
      ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
      return Provide<MainBottomProvider>(
        builder:(context,child,provider){
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: bottomTabs,
              type: BottomNavigationBarType.fixed,
              currentIndex: provider.currentIndex,
              onTap: (int newIndex){
                provider.changeCurrentIndex(newIndex); 
              }
            ),
            body: IndexedStack(
              index: provider.currentIndex,
              children: pages,
            ),
          );
        },
      );
  }
}