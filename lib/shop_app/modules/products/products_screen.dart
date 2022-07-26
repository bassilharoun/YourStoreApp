import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shop_app/layout/cubit/states.dart';
import 'package:shop_app/shop_app/models/categories_model.dart';
import 'package:shop_app/shop_app/models/home_model.dart';
import 'package:shop_app/shop_app/shared/colors.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: BlocConsumer<ShopCubit , ShopStates>(
          listener: (context , state) {
            if(state is ShopSuccessChangeFavState){
              if(state.model.status == false){
                showToast(text: state.model.message, state: ToastStates.ERROR);
              }
            }
          },
          builder: (context , state){
            return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productsBuilder(ShopCubit.get(context).homeModel , ShopCubit.get(context).categoriesModel,context),
              fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
            );
          },
        )
      ),
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CarouselSlider(
                items: model!.data!.banners.map((e) => Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )).toList(),
                options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal

                )),
          ),
        ),
        SizedBox(
          height:10,),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
              'Categories : ',
            style: TextStyle(fontSize: 24,color: defaultColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
                itemBuilder: (context , index) => buildCategoryItem(categoriesModel!.data!.data[index]),
                separatorBuilder: (context , index) => SizedBox(width: 10,),
                itemCount: categoriesModel!.data!.data.length
            ),
          ),
        ),

        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.7,
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              children: List.generate(
                  model.data!.products.length,
                      (index) => buildGridProduct(model.data!.products[index],context)),
            ),
          ),
        )

      ],
    ),
  );

  Widget buildCategoryItem(DataModel model) => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
              model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: 100,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
              fontSize: 14
            ),
          ),
        )
      ],),
  );

  Widget buildGridProduct(ProductModel model, context) => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Image(image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),

                  Row(children: [
                    if(model.discount != 0)
                      Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red[300],
                      child: Text(
                        'OFFER !',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(onPressed: (){
                      ShopCubit.get(context).changeFav(model.id);
                      print(model.id);
                    },
                        icon: Icon(
                          ShopCubit.get(context).fav[model.id]! ? Icons.favorite :Icons.favorite_border,
                          color: ShopCubit.get(context).fav[model.id]! ? Colors.red : Colors.grey,
                        ))
                  ],)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(children: [
                    Spacer(),
                    if(model.discount != 0)
                      Text(
                      '\$ ${model.oldPrice}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough

                      ),
                    ),
                    if(model.discount ==0)
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough

                        ),
                      )
                  ],),
                  Row(children: [
                    Text(
                      'Price',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16,color: Colors.grey[600]),
                    ),
                    Spacer(),
                    Text(
                      '\$ ${model.price}',
                      style: TextStyle(
                          fontSize: 16,
                          color: defaultColor

                      ),
                    )
                  ],),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
