import 'package:elect_project/pages/screens/screen1.dart';
import 'package:elect_project/pages/screens/screen2.dart';
import 'package:elect_project/pages/screens/screen3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartUpScreens extends StatefulWidget {
  const StartUpScreens({super.key});

  @override
  State<StartUpScreens> createState() => _StartUpScreensState();
}

class _StartUpScreensState extends State<StartUpScreens> {
  PageController pageController = PageController();
  String buttonText = "Skip";
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              currentPageIndex = index;
              if (index == 2) {
                buttonText = "Finish";
              } else {
                buttonText = "Skip";
              }
              setState(() {});
            },
            controller: pageController,
            children: [
              Screen1(),
              Screen2(),
              Screen3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    //Navigate to Direct in hompage
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey,
                  ),
                ),
                currentPageIndex == 2
                    ? SizedBox(
                        width: 10,
                      )
                    : GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
