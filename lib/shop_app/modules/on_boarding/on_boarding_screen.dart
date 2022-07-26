import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shop_app/shared/colors.dart';
import 'package:shop_app/shop_app/shared/components/components.dart';
import 'package:shop_app/shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body ;

  BoardingModel({
    required this.image ,
    required this.title ,
    required this.body
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'In Your Store',
        body: 'You can find everything you are looking for'),
    BoardingModel(
        image: 'assets/images/onboard_2.jpg',
        title: 'In Your Store',
        body: 'You can do a shopping at any time'),
    BoardingModel(
        image: 'assets/images/onboard_3.jpg',
        title: "It's really your store",
        body: 'We are lucky to have you here'),
  ];

  bool isLast = false ;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(context , LoginScreen());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(function: submit,
              text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index){
                if(index == boarding.length - 1){
                  setState(() {
                    isLast = true ;
                  }
                  );
                }else {
                  setState(() {
                    isLast = false ;
                  }
                  );
                }
              },
              physics: BouncingScrollPhysics(),
              controller: boardController,
              itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          Row(
            children: [
              SmoothPageIndicator(
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                  activeDotColor: defaultColor
                ),
                  controller: boardController, count: 3),
              Spacer(),
              FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    else{
                      boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.easeInCirc);
                    }

                  },
              child : Icon(Icons.arrow_forward_ios)
              )

            ],
          ),
        ],),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image(
          image: AssetImage('${model.image}')),
      SizedBox(
        height: 180,),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 30,
        ),

      ),
      SizedBox(
        height: 15,),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 23,
        ),

      ),
    ],) ;
}
