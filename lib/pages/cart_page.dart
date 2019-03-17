import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
      child: Text('0'),
    );
  }
}
class IButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){

      },
      child: Text('+1'),
    );
  }
}