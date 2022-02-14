import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/modules/shop_app/%20login/cubit/cubit.dart';
import 'package:test1/modules/shop_app/%20login/cubit/states.dart';
import 'package:test1/modules/shop_app/register/shop_register_screen.dart';

import '../../../shared/Component/component.dart';

class ShopLoginScreen extends StatelessWidget{

  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
   return  BlocProvider(
     create: (BuildContext context) =>ShopLoginCubit(),

     child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
       listener: (context,state){},
       builder: (context,state){
         return Scaffold(
           appBar: AppBar(),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:  [
                       Text('LOGIN',style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                       Text('Login now to browse our hot offers',style: Theme.of(context).textTheme.bodyText1!.copyWith(color:Colors.grey, ),),
                       const SizedBox(height: 30.0,),
                   defaultFormField(
                     controller: emailController,
                     type: TextInputType.emailAddress,
                     validate: (value)
                     {
                       if(value!.isEmpty)
                       {
                         return 'please enter your Email address';
                       }
                     },
                     label: 'Email Address',
                     prefix: Icons.email_outlined,
                   ),
                   const SizedBox(
                     height: 15.0,
                   ),
                   defaultFormField(
                     controller: passwordController,
                     type: TextInputType.visiblePassword,
                     onSubmit: (value) {
                       if (formKey.currentState!.validate()) {
                         ShopLoginCubit.get(context).userLogin(
                           email: emailController.text,
                           password: passwordController.text,
                         );
                       }

                     },
                     validate: (value) {
                       if (value!.isEmpty) {
                         return 'password is too short';
                       }
                     },
                     label: 'Password',
                     prefix: Icons.lock_outline,
                   ),
                   const SizedBox(
                     height: 30.0,
                   ),
                   ConditionalBuilder(
                     condition: state is! ShopLoginLoadingState,
                     builder: (context) => defaultButton(
                       function: () {
                         if (formKey.currentState!.validate()) {
                           ShopLoginCubit.get(context).userLogin(
                             email: emailController.text,
                             password: passwordController.text,
                           );
                         }
                       },
                       text: 'login',
                       isUpperCase: true,
                     ),
                     fallback: (context) => const Center(child: CircularProgressIndicator()),),
                       const SizedBox(
                         height: 15.0,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const Text('Don\'t have an account ?'),
                           TextButton(onPressed: (){navigateTo(context, ShopRegisterScreen());}, child: const Text('Register Now'))
                         ],),





                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
       },

     ),
   );
  }
}