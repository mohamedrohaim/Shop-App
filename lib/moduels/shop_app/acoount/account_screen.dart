import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/moduels/shop_app/cubit/states.dart';

import '../cubit/cubit.dart';

class accountScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    var model = ShopCubit
        .get(context)
        .userModel;
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state)
        {

        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                  condition: ShopCubit.get(context).userModel!=null,
                  builder: (context) =>
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Center(
                                child: Stack(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${model!.data!.image}'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: const BorderRadius
                                              .all(
                                              Radius.circular(95.0)),
                                          border: Border.all(
                                            color: Colors.redAccent,
                                            width: 4.0,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 130.0,

                                        ),
                                        child: Icon(Icons.camera_alt_sharp,
                                          color: Colors.black, size: 35.0,),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,),
                            Center(
                              child: Text('${model.data!.name}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            const SizedBox(
                              height: 20,),
                            const SizedBox(
                              height: 20,),
                            Text('${model.data!.phone}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500
                              ),),
                            const SizedBox(
                              height: 20,),
                            Text('${model.data!.email}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500
                              ),),


                          ],
                        ),


                      ),
                  fallback: (BuildContext context) =>
                      const Center(child: CircularProgressIndicator()))

          );
        }
    );
  }
}





