import 'package:edudibon_flutter_bloc/Screens/splashScreen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import 'package:edudibon_flutter_bloc/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _edudibonFadeAnimation; // Animation for edudibon.png

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust the duration as needed
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1), // Move UP by one full screen height (negative y)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0, // Fully visible
      end: 0.0, // Fully transparent
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _edudibonFadeAnimation = Tween<double>(
      begin: 0.0, // Initially hidden
      end: 1.0, // Fully visible
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().whenComplete(() {
      setState(() {}); // Trigger rebuild to start edudibon fade animation
      context.read<SplashScreenBloc>().add(SplashScreenAnimationCompleted());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late bool isLoggedIn;

  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void readData() async {
    print("checking prefs");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   // prefs.setBool('isLoggedIn', false);
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print("checking prefs");
    if(!isLoggedIn){
      saveData();
    }
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return BlocListener<SplashScreenBloc, SplashScreenState>(
    listener: (context, state) {
        if (state is SplashScreenCompleted) {
          Future.delayed(Duration(seconds: 2));
          if(isLoggedIn) {
              context.go(AppRoutes.otpConfirmation);
            }else{
            context.go(AppRoutes.splash2);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              // Background image (ss2.png)
              SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    'assets/images/ss2.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),

              // edudibon.png image (animated visibility) - Increased width
              FadeTransition(
                opacity: _edudibonFadeAnimation,
                child: Center(
                  child: Image.asset('assets/images/edudibon.png', width: 300), // Increased width to 250 (adjust as needed)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}