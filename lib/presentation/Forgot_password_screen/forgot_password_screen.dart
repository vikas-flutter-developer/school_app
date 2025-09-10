import 'package:edudibon_flutter_bloc/presentation/Forgot_password_screen/bloc/forgot_password_bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/Forgot_password_screen/bloc/forgot_password_event.dart';
import 'package:edudibon_flutter_bloc/presentation/Forgot_password_screen/bloc/forgot_password_state.dart';
import 'package:edudibon_flutter_bloc/presentation/set_new_password/set_new_password.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _userIdController = TextEditingController();
  String? _userIdError;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _validateUserId(String value) {
    if (value.isEmpty) {
      setState(() {
        _userIdError = 'User ID is required';
      });
    } else {
      setState(() {
        _userIdError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       GoRouter.of(context).pop();
      //     },
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: BlocProvider(
        create: (context) => ForgotPasswordBloc(),
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password reset successful!')),
              );
              context.go(AppRoutes.login);
            } else if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Don\'t worry we are here',
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  TextField(
                    controller: _userIdController,
                    onChanged: (value) {
                      _validateUserId(value);
                      context.read<ForgotPasswordBloc>().add(UserIdChanged(value));
                    },
                    style: GoogleFonts.openSans(fontSize: screenWidth * 0.045),
                    decoration: InputDecoration(
                      labelText: 'Enter Email Id',
                      labelStyle: GoogleFonts.openSans(fontSize: screenWidth * 0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      errorText: _userIdError,
                      errorStyle: GoogleFonts.openSans(fontSize: screenWidth * 0.035, color: Colors.redAccent),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  ElevatedButton(
                    onPressed: state is ForgotPasswordLoading || _userIdError != null
                        ? null
                        : () {
                      if (_userIdController.text.isNotEmpty) {
                        context.push(AppRoutes.setNewPassword);
                      } else {
                        _validateUserId(_userIdController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(double.infinity, screenHeight * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    ),
                    child: state is ForgotPasswordLoading
                        ? SizedBox(
                      height: screenHeight * 0.03,
                      width: screenHeight * 0.03,
                      child: const CircularProgressIndicator(color: Colors.white),
                    )
                        : Text(
                      'Set new password',
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