import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';
import 'provide/category_list_style.dart';
import 'provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/detail_info_provide.dart';
import 'provide/cart_provide.dart';
import 'provide/main_bottom_provider.dart';
void main(){
  ChildCategory childCategory =ChildCategory();
  CategoryListStyleProvider csp =CategoryListStyleProvider();
  CategoryGoodsListProvider cglp =CategoryGoodsListProvider();
  GoodsDetailProvider gdp = GoodsDetailProvider();
  CartProvider cp = CartProvider();
  MainBottomProvider mbp = MainBottomProvider();
  var providers =Providers();
  providers
  ..provide(Provider<ChildCategory>.value(childCategory))
  ..provide(Provider<CategoryListStyleProvider>.value(csp))
  ..provide(Provider<CategoryGoodsListProvider>.value(cglp))
  ..provide(Provider<GoodsDetailProvider>.value(gdp))
  ..provide(Provider<CartProvider>.value(cp))
  ..provide(Provider<MainBottomProvider>.value(mbp))
  ;
  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Container(
      child:MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
