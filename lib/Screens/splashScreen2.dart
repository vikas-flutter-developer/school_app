import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_routes.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  SplashScreen2State createState() => SplashScreen2State();
}

class SplashScreen2State extends State<SplashScreen2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, Map<String, String>>> _slides = [
    {
      'image': {'path': 'assets/images/ed2.png'},
      'text': {
        'heading': 'Welcome to Edudibon ERP',
        'message': 'Simplify school management\nwith a smart, all-in-one solution'
      },
    },
    {
      'image': {'path': 'assets/images/ed3.png'},
      'text': {
        'heading': 'Smart Student & Teacher Management',
        'message': 'Easily handle student records,\nteacher schedules, and attendance tracking'
      },
    },
    {
      'image': {'path': 'assets/images/ed4.png'},
      'text': {
        'heading': 'Exams, Fees & Performance Tracking',
        'message': 'Create exams, manage fee payments,\nand generate performance reports effortlessly'
      },
    },
    {
      'image': {'path': 'assets/images/ed2.png'},
      'text': {
        'heading': 'Stay Connected with AI Chat & Smart Notifications',
        'message': 'Get instant answers,\n send announcements& chat with teachers, students & parents effortlessly'
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _buildSlide(context, _slides[index], index);
              },
            ),
            Positioned(
              bottom: 40.0,
              left: 20.0,
              right: 20.0,
              child: _currentPage == _slides.length - 1
                  ? _buildGetStartedButton(context) // Show Get Started on last slide
                  : _buildBottomNavigation(context), // Show Skip, Next, and dots on other slides
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(BuildContext context, Map<String, Map<String, String>> slide, int index) {
    String message = slide['text']!['message']!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(height: 50), // Slightly moved everything lower
        Image.asset(
          slide['image']!['path']!,
          width: 280,
          height: 280,
        ),
        SizedBox(height: 40), // Small increase in gap
        Text(
          slide['text']!['heading']!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28, // Increased heading size
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25), // More gap between heading and text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0), // Slightly reduced padding
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // Dynamic width for better fitting
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.1, // Slightly reduced to fit two lines
                letterSpacing: -0.3, // Helps in squeezing words without affecting readability
              ),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(100)),
      ],
    );
  }

  /// **Bottom Navigation for First 3 Slides**
  Widget _buildBottomNavigation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSkipButton(context),
        _buildPageIndicator(),
        _buildNextButton(context),
      ],
    );
  }

  /// **"Get Started" Button for Last Slide**
 Widget _buildGetStartedButton(BuildContext context) {
  return Column(
    children: [
      ElevatedButton(
        onPressed: () {
          context.go(AppRoutes.login);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade900, // Dark Blue Color
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 80), // Adjusted horizontal padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(250, 50), // Ensures button has a proper width
        ),
        child: Text(
          "Let's Get Started",
          style: TextStyle(fontSize: 18, color: Colors.white),
          textScaleFactor: 1, // Prevents unexpected scaling
        ),
      ),
      SizedBox(height: 40), // Space between button and sliding dots
      _buildPageIndicator(), // Keep sliding dots below the button
    ],
  );
}


  //s kip button
  Widget _buildSkipButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _pageController.jumpToPage(_slides.length - 1);
      },
      child: Text('Skip', style: TextStyle(fontSize: 18,color: AppColors.silver)),
    );
  }

  //next button 
  Widget _buildNextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Text('Next', style: TextStyle(fontSize: 18,color: AppColors.blackHighEmphasis)),
    );
  }

  //pagination 
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _slides.length,
        (index) => _buildDot(index),
      ),
    );
  }

  // dots 
  Widget _buildDot(int index) {
  return GestureDetector(
    onTap: () {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 7, // Slightly increased for better visibility
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1), // Black border
        color: _currentPage == index ? Colors.deepPurple : Colors.transparent, // Transparent when inactive
      ),
    ),
  );
}
}
