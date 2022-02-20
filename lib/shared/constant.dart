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