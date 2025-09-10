import 'dart:async';

import 'package:edudibon_flutter_bloc/admin_module/inventory_management/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_confirmation_screen/otp_confirmation_screen.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_login_screen/bloc/otp_login_bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_login_screen/bloc/otp_login_event.dart';
import 'package:edudibon_flutter_bloc/presentation/otp_login_screen/bloc/otp_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../routes/app_routes.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpLoginScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
        (_) => TextEditingController(),
  );
  String otp = '';
  Timer? _timer;
  int _countDown = 90; // 1:30 minutes in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String get _formattedTime {
    final minutes = (_countDown ~/ 60).toString().padLeft(1, '0');
    final seconds = (_countDown % 60).toString().padLeft(2, '0');
    return '$minutes.$seconds min left';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            _showAlertDialog(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => OtpBloc(),
        child: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpSuccess) {
              context.go(AppRoutes.otpConfirmation);
            } else if (state is OtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is ResendOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Resent')));
              _countDown = 90;
              startTimer();
            } else if (state is ResendOtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is OtpLoading || state is ResendOtpLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.02),
                  Image.asset(
                    'assets/images/edudibon_logo.png',
                    height: screenHeight * 0.04,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Please Verify Account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    'Enter the 4 digit OTP we sent on your \n mail/ph no to verify your account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff757575),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                          (index) => SizedBox(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.15, // Adjusted height for square boxes
                        child: TextField(
                          controller: _otpControllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w600,
                            //color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: '*', // Added hint text
                            hintStyle: GoogleFonts.openSans(
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff9D9B9B)
                              //color: Colors.grey.shade300,
                            ),
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.06),
                              borderSide: BorderSide(color: Color(0xff9D9B9B)),
                            ),
                            /*focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),*/
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (index == 3 && value.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _countDown == 0
                            ? () {
                          context.read<OtpBloc>().add(ResendOtpPressed());
                        }
                            : null,
                        child: Text(
                          'Resend code',
                          style: GoogleFonts.openSans(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w400,
                            color: _countDown == 0 ? Colors.blue : Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Text(
                        _formattedTime,
                        style: GoogleFonts.openSans(
                          fontSize: screenWidth * 0.038,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  ElevatedButton(
                    onPressed: ()=>context.go(AppRoutes.otpConfirmation),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(double.infinity, screenHeight * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                    ),
                    child: Text(
                      'Verify & Continue',
                      style: GoogleFonts.openSans(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

_showAlertDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // Set the title of the dialog
        title: Text(
          "Are you sure you want go back?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppStyles.size.heading
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 'No' button on the left, a simple text button
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.silver,width: 2),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: AppStyles.size.heading,                    ),
                  ),
                ),
              ),
              // 'Yes' button on the right, with a filled background
              GestureDetector(
                onTap: () {
                  context.go(AppRoutes.login);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppStyles.size.heading,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}