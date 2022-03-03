import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/favorites_modele.dart';
import '../../../shared/component.dart';
import '../../../shared/constant.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class FavoritesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context,)
  {

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){
        },
    builder:(context,state) {
      return ConditionalBuilder(
        condition: ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
        builder: (context)=>ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
          separatorBuilder: (context,index)=>const SizedBox(width: 20.0,),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,),
        fallback: (context)=>  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const
          [
            Icon(Icons.sentiment_very_dissatisfied_rounded,size: 100.0,color: Colors.grey),
            Text('Favorites Is Empty',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey,

              ),),
          ],),
        ),
      );
      },
        );

  }

  Widget buildFavItem(FavoritesData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 140,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
               Image(image:  NetworkImage('${model.product!.image}'),
                height: 140.0,
                width: 120,
              ),
              if(model.product!.discount!=0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text('Discount',style:TextStyle(
                    fontSize: 11.0,
                    color: Colors.white,
                  ) ,),
                ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('${model.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3
                  ),

                ),
                Spacer(),
                Row(
                  children: [
                     Text('${model.product!.price.toString()} ',
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: defaultColor2,
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    if(model.product!.discount != 0) Text(model.product!.oldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                         ShopCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon:   CircleAvatar(
                          radius: 14.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.product!.id]==true ?defaultColor : Colors.grey,
                         // backgroundColor: defaultColor,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 20.5,),
                        ))

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}