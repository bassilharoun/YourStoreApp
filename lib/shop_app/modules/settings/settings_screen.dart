import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shop_app/layout/cubit/states.dart';
import 'package:shop_app/shop_app/shared/colors.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';
import 'package:shop_app/shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {
        if(state is ShopSuccessUserDataState){

        }
      },
      builder: (context , state){
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(color: defaultColor,
                      backgroundColor: Colors.grey[200],),
                    SizedBox(height: 20,),
                    Container(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundColor: defaultColor,
                        child: Image(
                          image: NetworkImage('https://yannflucksa.ch/wp-content/uploads/2020/02/user.png')
                          ,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    defaultTxtForm(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'So What\'s your name ?';
                          }
                          return null ;
                        },
                        label: 'Name',
                        prefix: Icons.person
                    ),
                    SizedBox(height: 20,),
                    defaultTxtForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'We need your email !';
                          }
                          return null ;
                        },
                        label: 'Email',
                        prefix: Icons.alternate_email
                    ),
                    SizedBox(height: 20,),
                    defaultTxtForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'So What\'s your phone number ?';
                          }
                          return null ;
                        },
                        label: 'Phone',
                        prefix: Icons.phone_iphone_rounded
                    ),
                    SizedBox(height: 20,),
                    defaultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text
                            );
                          }

                        }, text: 'Update'

                    ),
                    SizedBox(height: 15,),
                    defaultTextButton(
                        function: (){
                          signOut(context);
                        },
                        text: 'Logout',
                      color: Colors.red
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator(color: defaultColor,)),
        );
      },
    );
  }
}
