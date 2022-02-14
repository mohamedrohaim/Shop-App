import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test1/modules/shop_app/%20login/shopLoginScreen.dart';
import 'package:test1/shared/Component/component.dart';
import '../../shared/colors.dart';

class BoardingModel
{
   final String image;
   final String title;
   final String body;
BoardingModel({
    required this.image,
  required this.body,
  required this.title
});


}

class OnBoardingScreen extends StatefulWidget{

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<BoardingModel> boarding=[
    BoardingModel(image: 'assets/images/image1.png', body: 'There are many products', title: 'Discover Your Fave Shop'),
    BoardingModel(image: 'assets/images/image2.png', body: 'special discounts', title: 'Save Payment Method'),
    BoardingModel(image: 'assets/images/image3.png', body: 'Delivery in time', title: 'Get your Order Fast'),

  ];
   bool isLast=false;


  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()
          {
            navigateAndFinish(context, ShopLoginScreen());
          }, child: Text('skip',),),

        ],

      ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(

              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index)
                {
                  if(index==boarding.length - 1)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }else
                    {
                      setState(() {
                        isLast=false;
                      });
                    }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children:  [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    expansionFactor: 4.0,
                    dotWidth: 10.0,
                    spacing: 10,
                  ),
                  count: boarding.length,),
                const Spacer(),
                FloatingActionButton(onPressed:()
                {
                  if(isLast==true)
                  {
                    navigateAndFinish(context, ShopLoginScreen());

                  }else
                  {
                    boardController.nextPage
                      (duration: const Duration(
                        milliseconds: 1400),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }

                },
                child:const Icon(Icons.arrow_forward_ios) ,),
              ],
            ),

          ],
        ),
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Expanded(child: Image.asset(model.image,),
      ),
      const SizedBox( height:30.0),
       Text(model.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),),
      const SizedBox( height:30.0),
       Text(model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),),
      const SizedBox( height:30.0),

    ],
  );
}