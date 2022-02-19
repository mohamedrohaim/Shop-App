
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/component.dart';
import '../../shared/constant.dart';
import '../../shared/network/local/shared_prefrences.dart';
import '../login_screen/login_screen.dart';
class BoardingModel
{
  late String image;
  late String title;
  late String body;
  BoardingModel({required this.image,required this.body,required this.title});
}
class OnBoardingScreen extends StatefulWidget
{
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardcontroller=PageController();
  List<BoardingModel> boarding=
  [
    BoardingModel(title: 'Discover Your Fave Shop ', body: 'There are many Products  ', image: 'assets/images/image1.jpg'),
    BoardingModel(title: 'Save Payment Method', body: 'Special discounts ', image: 'assets/images/image2.png'),
    BoardingModel(title: 'Get your Order Fast', body: 'Delivery in time ', image: 'assets/images/image3.png'),
  ];
  bool isLast=false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value)
        {
          navigateAndFinished(context, ShopLoginScreen());
        }
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
        appBar: AppBar(
          actions: [TextButton(onPressed: (){ submit();}, child: const Text('SKIP'))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children:  [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index)
                  {
                    if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                      print('last');
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  controller: boardcontroller,
                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children:   [
                  SmoothPageIndicator(controller:boardcontroller , count: boarding.length,
                    effect:    const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5
                    ),),
                  const Spacer(),
                  FloatingActionButton(onPressed: (){
                    if(isLast)
                    {
                      submit();

                    }else{
                      boardcontroller.nextPage(duration: const Duration(milliseconds:750 ), curve:Curves.fastLinearToSlowEaseIn );
                    }
                  },child:const Icon(Icons.arrow_forward_ios),)
                ],
              )
            ],
          ),
        )
    );
  }
  Widget buildBoardingItem(BoardingModel boarding)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child: Image(image: AssetImage(boarding.image))) ,
      const SizedBox(
        height: 30.0,
      ),
      Text(boarding.title,style: const TextStyle(fontSize: 24.0,fontWeight:FontWeight.bold,),),
      const SizedBox(
        height: 15.0,
      ),
      Text(boarding.body,style: const TextStyle(fontSize: 14.0,fontWeight:FontWeight.bold,),),
    ],
  );
}
