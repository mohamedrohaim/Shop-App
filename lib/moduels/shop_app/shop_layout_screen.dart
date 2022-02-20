import 'package:flutter/material.dart';
import 'package:test1/moduels/login_screen/login_screen.dart';
import 'package:test1/shared/component.dart';
import 'package:test1/shared/network/local/shared_prefrences.dart';

class ShopLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('shop layout'),),
      body: TextButton(onPressed: ()
      {
        CacheHelper.DeleteData(key: 'token').then((value){
          if(value)
          {
            navigateAndFinished(context, ShopLoginScreen());
          }
        });

      },child: const Text('sign out'),),
    );
  }


}