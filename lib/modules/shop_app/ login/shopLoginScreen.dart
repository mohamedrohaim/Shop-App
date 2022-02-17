import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/modules/shop_app/%20login/cubit/cubit.dart';
import 'package:test1/modules/shop_app/%20login/cubit/states.dart';
import 'package:test1/modules/shop_app/register/shop_register_screen.dart';

import '../../../shared/Component/component.dart';
import '../../../shared/colors.dart';

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
          appBar: AppBar(
            title: Text(
              'LOGIN',style: Theme.of(context).textTheme.headline4!.copyWith(color: defaultColor),),
          ),
           body: Center(
             child: SingleChildScrollView(
               physics: const BouncingScrollPhysics(),
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(

                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:  [
                       Container(
                           width: 500.0,
                           height: 300.0,
                           child: Image.asset('assets/images/login.jpg',)),
                       const SizedBox(height: 30.0,),
                   defaultFormField(
                     controller: emailController,
                     type: TextInputType.emailAddress,
                    validate: (value) {
                          if (value!.isEmpty) {
                          return 'email mustn\'t be empty';}},
                     label: 'Email Address',
                     prefix: Icons.email_outlined,
                   ),
                   const SizedBox(
                     height: 15.0,
                   ),
                   defaultFormField(
                     controller: passwordController,
                     isPassword: ShopLoginCubit.get(context).isPassword,
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
                         return 'password mustn\'t be empty';
                       }
                       return null;
                     },
                     label: 'Password',
                     prefix: Icons.lock_outline,
                     suffix: ShopLoginCubit.get(context).suffix,
                     suffixPressed: ()

                     {
                       ShopLoginCubit.get(context).changePasswordVisibility();
                     },
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