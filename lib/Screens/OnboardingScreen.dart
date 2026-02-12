import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shyal/Component/CustomButton.dart';
import 'package:shyal/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     final EdgeInsets padding = MediaQuery.of(context).padding;

//     return Scaffold(
//       backgroundColor: const Color(0xffF7F7F7),
//       body: Stack(
//         children: <Widget>[
//           Positioned.fill(
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: screenSize.height * 0.25),
//                     child: Image.asset('assets/img/1.jpg',
//                         scale: MediaQuery.of(context).size.width / 400),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//               top: padding.top,
//               right: 15,
//               child: Row(
//                 children: [
//                   Text(
//                     "Skip",
//                     style: TextStyle(
//                         color: Colors.black, fontSize: screenSize.width * 0.05),
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.arrow_circle_right_rounded,
//                         size: screenSize.width * 0.11,
//                         color: green,
//                       ))
//                 ],
//               )),
//           const Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: CustomBottomSheet(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class OnboardingData {
  final int index;
  final String imagePath;
  final String title;
  final String description;

  OnboardingData(
      {required this.imagePath,
      required this.title,
      required this.description,
      required this.index});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      index: 0,
      imagePath: 'assets/img/1.jpg',
      title: 'Best package delivery just for you',
      description:
          'It is a long established fact that a reader will be distracted by the readable content.',
    ),
    OnboardingData(
      index: 1,
      imagePath: 'assets/img/2.jpg',
      title: 'Fast and Reliable',
      description:
          'Our service ensures your delivery is fast and reliable, making your life easier.',
    ),
    OnboardingData(
      index: 2,
      imagePath: 'assets/img/3.jpg',
      title: 'Worldwide Shipping',
      description:
          'We offer worldwide shipping, allowing you to send packages across the globe.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              return OnboardingContent(
                page: onboardingPages[index],
                pageController: _controller,
                totalPages: onboardingPages.length,
              );
            },
          ),
          Positioned(
            top: padding.top,
            right: 15,
            child: Row(
              children: [
                Text(
                  "Skip",
                  style: TextStyle(
                      color: Colors.black, fontSize: screenSize.width * 0.05),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loginScreen');
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_rounded,
                    size: screenSize.width * 0.11,
                    color: green,
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

class OnboardingContent extends StatelessWidget {
  final OnboardingData page;
  final PageController pageController;
  final int totalPages;

  const OnboardingContent(
      {super.key,
      required this.page,
      required this.pageController,
      required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(page.imagePath),
        ),
        CustomBottomSheet(
          title: page.title,
          description: page.description,
          index: page.index,
          pageController: pageController,
          totalPages: totalPages,
        ),
      ],
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key,
      required this.title,
      required this.description,
      required this.index,
      required this.pageController,
      required this.totalPages});

  final String title;
  final String description;
  final int index;
  final PageController pageController;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double bottomSheetHeight = screenSize.height * 0.37;
    final double screenWidth = screenSize.width;

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: background_color,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.09,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: bottomSheetHeight * 0.09,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: bottomSheetHeight * 0.05,
                    ),
                  ],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: totalPages,
              effect: const ExpandingDotsEffect(
                spacing: 8.0,
                dotWidth: 10.0,
                dotHeight: 10.0,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: Colors.green,
              ),
            ),
            SizedBox(
              height: bottomSheetHeight * 0.1,
            ),
            CustomButton(
                title: index == totalPages - 1 ? 'Login' : 'Next',
                onPressed: () {
                  if (index == totalPages - 1) {
                    Navigator.pushReplacementNamed(context, '/LoginScreen');
                  } else {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.easeInOut,
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget buildDot(
      {required int index,
      required int currentIndex,
      required double screenWidth}) {
    return Container(
      width: screenWidth * 0.025,
      height: screenWidth * 0.025,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: index == currentIndex ? Colors.green : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
