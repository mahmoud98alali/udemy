import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy/modules/shop_app/login_screen/login_screen.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';

import '../../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/screen11.png',
      body: 'Screen Title',
      title: 'Screen Body',
    ),
    BoardingModel(
      image: 'assets/images/screen2.png',
      body: 'Screen Title2',
      title: 'Screen Body2',
    ),
    BoardingModel(
      image: 'assets/images/screen3.png',
      body: 'Screen Title3',
      title: 'Screen Body3',
    ),
  ];

  bool isList = false;


  void submit(){

    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {

      if(value == true){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: submit,
              title: "SKIP",
             style: const TextStyle(fontSize: 16.0),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isList = true;
                    });
                  } else {
                    setState(() {
                      isList = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      activeDotColor: defaultColor,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5.0),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {

                    if(isList==false){
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastOutSlowIn);
                    }else{
                      submit();
                    }

                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
