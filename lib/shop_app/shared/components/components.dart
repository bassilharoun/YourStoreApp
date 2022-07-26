import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shop_app/shared/colors.dart';

void navigateTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder:  (context) => widget)) ;

void navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder:  (context) => widget),
    (route) => false
) ;


Widget defaultTxtForm({
  required TextEditingController controller ,
  required TextInputType type ,
  Function(String)? onSubmit ,
  VoidCallback? onTap ,
  Function(String)? onChanged ,
  required String? Function(String?)? validate ,
  required String label ,
  IconData? prefix ,
  IconData? suffix = null ,
  bool isPassword = false,
  bool isClickable = true ,
  VoidCallback? onSuffixPressed ,

}) => TextFormField(
  validator: validate,
  obscureText: isPassword,
  controller: controller,
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: GestureDetector(
        child: Icon(suffix),
        onTap: onSuffixPressed,
      ),
      border: OutlineInputBorder()
  ),
  keyboardType: type,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap: onTap,

) ;


Widget defaultButton({
  double width = double.infinity ,
  Color background = defaultColor ,
  required VoidCallback function ,
  required String text ,
  bool isUpperCase = true,


}) => Container(
  width: width,
  child: MaterialButton(
    height: 50,
    onPressed: function,
    child: Text(isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(color: Colors.white),),
  ),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
    color: background,
  ),
);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  Color color = defaultColor ,

}) => TextButton(onPressed: function
    ,child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color , fontSize: 16),
    ));

void showToast({
  required String text ,
  required ToastStates state ,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS , ERROR , WARNING}
Color? chooseToastColor(ToastStates state){
  Color? color ;
  switch(state){
    case ToastStates.SUCCESS:
      color = defaultColor;
      break;
    case ToastStates.ERROR:
      color = Colors.pink;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color ;

}

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: defaultColor,
  ),
);

Widget buildListItem(model , context , {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 5),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      color: Colors.white,
      height: 120,
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(model.image),
                ),

                Row(children: [
                  if(model.discount != 0 && isOldPrice)
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
                  },
                      icon: Icon(
                        // ShopCubit.get(context).fav[model.id]!
                        true
                            ? Icons.favorite :Icons.favorite_border,
                        color: ShopCubit.get(context).fav[model.id]! ? Colors.red : Colors.grey,
                      ))
                ],)
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(children: [
                    Spacer(),
                    if(model.discount != 0 && isOldPrice)
                      Text(
                        '\$ ${model.oldPrice}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough

                        ),
                      ),
                    if(model.discount == 0 && isOldPrice)
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
            ),
          )
        ],
      ),
    ),
  ),
);
