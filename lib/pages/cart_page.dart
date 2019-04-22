import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
// class CartPage extends StatefulWidget {
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Provide<Counter>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Number(),
            IButton(),
          ],
        ),
      ),
    );
  }
}
class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Provide<Counter>(
          builder:(context,child,counter){
              return Text(
              '${counter.count}',
              style: Theme.of(context).textTheme.display1,
            );
          },
      ),
    );
  }
}
class IButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
          onPressed: (){
            Provide.value<Counter>(context).increment();
          },
          child: Text('+1'),
        );

    
  }
}