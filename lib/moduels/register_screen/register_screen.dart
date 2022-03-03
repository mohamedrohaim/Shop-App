
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component.dart';
import '../../shared/constant.dart';
import '../../shared/network/local/shared_prefrences.dart';
import '../shop_app/shop_layout_screen.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen  extends StatelessWidget {
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  var passController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context)=>ShopRegisterCubit(),
        child:BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context,state)
          {
            if(state is ShopRegisterSuccessState)
            {
              if(state.loginModel!.status!)
              {
                print(state.loginModel!.data!.token);
                print(state.loginModel!.message);
                showToast(states: ToastStates.SUCCESS, text:state.loginModel!.message!, );
                CacheHelper.saveData(key: 'token',value: state.loginModel!.data!.token,).then(
                        (value) {
                      navigateAndFinished(context, ShopLayout());
                    });

              }
              else
              {
                print(state.loginModel!.message);
                showToast(states: ToastStates.ERROR, text:state.loginModel!.message!,);
              }
            }
          },
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                title: const Text('REGISTER ',style: TextStyle(color: defaultColor),),
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
                        Center(child: Image.asset('assets/images/register.png',height: 200,width: 200,)),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            type: TextInputType.name,
                            label: 'User Name',
                            prefix: Icons.person,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'name must not be empty ';
                              }

                            },
                            controller: nameController
                        ),

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
                          height: 30,
                        ),


                        defaultFormField(
                            type: TextInputType.phone,
                            label: 'Phone Number',
                            prefix: Icons.phone_iphone_sharp,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'phone must not be empty ';
                              }

                            },
                            controller: phoneController,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            type: TextInputType.visiblePassword,
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            onSubmit: (value)
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(email: emailController.text,
                                    password: passController.text,
                                    name: nameController.text, phone: phoneController.text)
                              ;
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
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                            }
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => Center(
                            child: defaultButton(
                              width: 250,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passController.text,
                                    name: nameController.text,
                                    phone: phoneController.text
                                  );
                                }
                              },
                              text: 'REGISTER NOW',
                              isUpperCase: true,
                            ),
                          ),
                          fallback: (context) =>
                          const  Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
}}
