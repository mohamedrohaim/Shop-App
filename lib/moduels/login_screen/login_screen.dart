import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test1/shared/network/local/shared_prefrences.dart';
import '../../shared/component.dart';
import '../../shared/constant.dart';
import '../register_screen/register_screen.dart';
import '../shop_app/shop_layout_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

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
                  showToast(states: ToastStates.SUCCESS, text:state.loginModel!.message);
                  CacheHelper.saveData(key: 'token',value: state.loginModel!.data!.token,).then(
                          (value) {
                            navigateAndFinished(context, ShopLayout());
                          });

                }
              else
                {
                  print(state.loginModel!.message);
                  showToast(states: ToastStates.ERROR, text:state.loginModel!.message);
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
