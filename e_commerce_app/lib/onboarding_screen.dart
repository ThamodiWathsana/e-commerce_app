import 'package:flutter/material.dart';

import 'signin_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPage(
                image: 'assets/onboarding1.png',
                titleParts: ['Seamless', 'Shopping Experience'],
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildPage(
                image: 'assets/onboarding2.png',
                titleParts: ['Wishlist: Where', 'Fashion Dreams', 'Begin'],
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildPage(
                image: 'assets/onboarding3.png',
                titleParts: ['Swift and Reliable', 'Delivery'],
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
            ],
          ),
          Positioned(
            top: 50.0,
            left: 30.0,
            child: Text(
              'insightlancer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade300,
                letterSpacing: 1.2,
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 10,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.brown, fontSize: 16),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => _buildDot(index)),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child:
                _currentPage > 0
                    ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.brown, width: 2),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.brown),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        iconSize: 20,
                        padding: EdgeInsets.all(8),
                      ),
                    )
                    : Container(),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.brown,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                iconSize: 20,
                padding: EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required List<String> titleParts,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 400, fit: BoxFit.cover),
        SizedBox(height: 20),
        Column(
          children:
              titleParts
                  .map(
                    (part) => Text(
                      part,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            [
                                  'Seamless',
                                  'Fashion Dreams',
                                  'Swift and Reliable',
                                ].contains(part)
                                ? Colors.brown
                                : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                  .toList(),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: _currentPage == index ? 12 : 8,
      width: _currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.brown : Colors.grey,
      ),
    );
  }
}
