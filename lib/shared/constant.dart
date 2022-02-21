import 'package:flutter/material.dart';

import '../moduels/login_screen/login_screen.dart';
import 'component.dart';
import 'network/local/shared_prefrences.dart';

const defaultColor=Colors.deepPurple;


void sinOut(context)
{
  CacheHelper.DeleteData(key: 'token').then((value){
    if(value)
    {
      navigateAndFinished(context, ShopLoginScreen());
    }
  });
}
void printFullText(String text) {
  final pattern = RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

dynamic token='token';