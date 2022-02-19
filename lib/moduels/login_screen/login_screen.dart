import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/component.dart';
import '../../shared/constant.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);
var emailController=TextEditingController();
var passController=TextEditingController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child:BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel!.status)
                {
                  print(state.loginModel!.data!.token);
                  print(state.loginModel!.message);
                  Fluttertoast.showToast(
                      msg: state.loginModel!.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              else
                {
                  print(state.loginModel!.message);
                  Fluttertoast.showToast(
                      msg: state.loginModel!.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      );
                }
            }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('LOGIN',style: TextStyle(color: defaultColor),),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Image.asset('assets/images/login.jpg'),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'email must not be empty ';
                            }

                          },
                          controller: emailController
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          type: TextInputType.visiblePassword,
                         isPassword: ShopLoginCubit.get(context).isPassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(email: emailController.text,  password: passController.text);
                              }
                          },
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password must not be empty ';
                            }
                          },
                          controller: passController,
                        suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                        }
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                        const  Center(child: CircularProgressIndicator()),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          const Text('Don\'t have an account '),
                          const Spacer(),
                          TextButton(onPressed: (){
                            navigateTo(context,const RegisterScreen());
                          }, child:const Text('Register now'))

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
