import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class productsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text(
          'products screen',
        style: Theme.of(context).textTheme.bodyText1,

      ),
    );
  }
}