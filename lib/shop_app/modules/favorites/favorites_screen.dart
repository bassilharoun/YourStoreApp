import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shop_app/layout/cubit/states.dart';
import 'package:shop_app/shop_app/models/fav_model.dart';
import 'package:shop_app/shop_app/shared/colors.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        return Container(
          color: Colors.grey[200],
          child: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) => buildListItem(ShopCubit.get(context).favModel!.data!.data![index].product, context),
                separatorBuilder: (context , index) => SizedBox(),
                itemCount: ShopCubit.get(context).favModel!.data!.data!.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)) ,
          ),
        );
      },
    );
  }


}
