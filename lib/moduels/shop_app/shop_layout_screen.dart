import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/moduels/shop_app/cubit/cubit.dart';
import 'package:test1/moduels/shop_app/cubit/states.dart';
import 'package:test1/moduels/shop_app/search/search_screen.dart';
import 'package:test1/shared/component.dart';

import '../../shared/constant.dart';
import 'acoount/account_screen.dart';


class ShopLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state)
      {
      },
      builder: (context,state){
        var cubit=ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('XMR SHOP'),
            actions: [

              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon: const Icon(Icons.search),iconSize: 25,),
              IconButton(onPressed: (){
                sinOut(context);
              }, icon: const Icon(Icons.logout,size: 25.0,)),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    iconSize: 35,
                    onPressed: (){
                  navigateTo(context, accountScreen());
                }, icon:  Icon(Icons.account_circle,),
                ),
              )



            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items:  const [
              BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps,),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Account'),

            ],
          ),
        );
      },
    );
  }


}