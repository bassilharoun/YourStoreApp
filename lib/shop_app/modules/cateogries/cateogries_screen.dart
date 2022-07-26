import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shop_app/layout/cubit/states.dart';
import 'package:shop_app/shop_app/models/categories_model.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        return Container(
          color: Colors.grey[200],
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context , index) => buildCategoriesPageItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context , index) => SizedBox(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length
          ),
        );
      },
    );
  }

  Widget buildCategoriesPageItem(DataModel model) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0 ,vertical: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white,
        height: 200,
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  model.image),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              child: Text(
                model.name,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 24,
                  overflow: TextOverflow.ellipsis,
                ),

              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.arrow_forward_ios),
            )
          ],),
      ),
    ),
  );
}
