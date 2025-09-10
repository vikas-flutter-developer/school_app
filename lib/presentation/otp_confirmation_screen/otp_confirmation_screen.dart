import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'bloc/otp_confirmation_bloc.dart';
import 'bloc/otp_confirmation_event.dart';
import 'bloc/otp_confirmation_state.dart';

class OtpConfirmationScreen extends StatelessWidget {
  const OtpConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (context) => ConfirmationBloc(),
        child: BlocConsumer<ConfirmationBloc, ConfirmationState>(
          listener: (context, state) {
            if (state is ConfirmationSuccess) {
              // context.go(AppRoutes.adminDashboard);
              // context.go(AppRoutes.teacherDashboard);
              // context.go(AppRoutes.studentDashboard);
            } else if (state is ConfirmationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is ConfirmationLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Congratulations',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your account is verified',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 30),
                    Image.asset('assets/images/checkmark.png', height: 100),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        // context.read<ConfirmationBloc>().add(ContinueButtonPressed());
                        context.push(AppRoutes.adminDashboard);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4C45B5),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Apply circular border radius here
                        ),
                      ),
                      child: Text('Continue to admin',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        // context.read<ConfirmationBloc>().add(ContinueButtonPressed());
                        context.push(AppRoutes.teacherDashboard);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4C45B5),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Apply circular border radius here
                        ),
                      ),
                      child: Text('Continue to teacher',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        // context.read<ConfirmationBloc>().add(ContinueButtonPressed());
                        context.push(AppRoutes.studentDashboard);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4C45B5),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Apply circular border radius here
                        ),
                      ),
                      child: Text('Continue to student',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}