import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shop_app/layout/shop_layout.dart';
import 'package:shop_app/shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shop_app/modules/signup/signup_screen.dart';
import 'package:shop_app/shop_app/shared/colors.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';
import 'package:shop_app/shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener: (context , state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token).then((value) {
                    token = state.loginModel.data!.token ;
                    navigateAndFinish(context, ShopLayout());
              });
            }else{
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context , state){
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
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: defaultColor
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'I think we are lucky to have you here !',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 30,),
                        defaultTxtForm(controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty){
                                return "Your email can't be empty !";
                              }

                            },
                            label: 'Email',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTxtForm(controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty){
                                return "Password is too short !";
                              }
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            label: 'Password',
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            prefix: Icons.lock_open_outlined,
                            suffix: ShopLoginCubit.get(context).suffix,
                            onSuffixPressed: (){
                          ShopLoginCubit.get(context).changePasswordVisibility();
                            }
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'Login'
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(fontSize: 16),
                            ),
                            defaultTextButton(function: (){
                              navigateTo(context , SignupScreen());
                            }, text: 'Signup'),

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
