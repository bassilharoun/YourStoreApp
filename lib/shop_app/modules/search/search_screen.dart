import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shop_app/shared/colors.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , state){},
        builder:(context , state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTxtForm(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value!.isEmpty){
                            return 'What are you looking for ?';
                          }
                          return null ;
                        },
                        label: 'Search',
                      prefix: Icons.search,
                      onChanged: (text){
                          SearchCubit.get(context).Search(text);
                      }
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(color: defaultColor,backgroundColor: Colors.grey[300],),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context , index) => buildListItem(SearchCubit.get(context).model!.data!.data![index], context , isOldPrice: false),
                          separatorBuilder: (context , index) => SizedBox(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
