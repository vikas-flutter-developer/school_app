import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: SizedBox(), // To remove back button spacing
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Congratulations',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Your password is updated',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Container(
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF4C45B5), // Example purple color
                    width: screenWidth * 0.02,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: screenWidth * 0.15,
                    color: const Color(0xFF4C45B5),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
              ElevatedButton(
                onPressed: ()=>context.go(AppRoutes.adminDashboard),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C45B5), // Example purple color
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                child: Text(
                  'Log In',
                  style: GoogleFonts.openSans(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}