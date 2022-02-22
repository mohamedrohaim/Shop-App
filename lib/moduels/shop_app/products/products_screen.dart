
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/models/categories_modele.dart';
import 'package:test1/models/home_model.dart';
import 'package:test1/moduels/shop_app/cubit/cubit.dart';

import '../../../shared/constant.dart';
import '../cubit/states.dart';

class productsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesModel!=null,
            builder:(context)=> productsBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!) ,
          fallback: (context)=>const Center(child: CircularProgressIndicator()),

        );
      },

    ) ;
   
  }
  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel)=>SingleChildScrollView(
    physics:  const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
         CarouselSlider(items:model.data!.banners.map((e) => Image(
             width: double.infinity,
             fit: BoxFit.cover,
             image: NetworkImage('${e.image}')), ).toList() ,
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay:true ,
             autoPlayInterval: const Duration(seconds: 3),
             autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          ),),
        const SizedBox(height: 10.0),
       Padding(
         padding: const EdgeInsets.symmetric(
           horizontal: 10.0
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const Text('Categories',
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.w500,
               ),
             ),
             const SizedBox(height: 10.0),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) =>buildCategoryItem(categoriesModel.data!.data[index]) ,
                   separatorBuilder:(context,index)=> const SizedBox(width: 10.0,),
                  itemCount: categoriesModel.data!.data.length,
                   ),
              ),
              const SizedBox(height: 20.0),
              const Text('New Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
           ],
         ),
       ),
        const SizedBox(height: 10.0),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 7.0,
            crossAxisSpacing: 7.0,
            childAspectRatio: 1/1.50,
            children:List.generate(model.data!.products.length, (index) => buildGridProdct(model.data!.products[index])) ,

          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:  [
       Image(image: NetworkImage('${model.image}'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
          color: Colors.black.withOpacity(0.8),
          width: 100.0,
          child:   Text(
            '${model.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          )),
    ],
  );

  Widget buildGridProdct(ProductModel model)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image!),
            width: double.infinity,
              height: 200.0,
            ),
            if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(1.44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.3
              ),

              ),
              Row(
                children: [
                  Text('${model.price.round()}',
                    style: const TextStyle(
                     fontSize: 13.0,
                      color: defaultColor2,
                    ),
                  ),
                  const SizedBox(width: 5.0,),
                  if(model.discount!=0)Text('${model.oldPrice.round()}',
                    style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                        ),
                         ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.only(right: 5.0),
                      onPressed: (){},
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 19.5,))

                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );
}