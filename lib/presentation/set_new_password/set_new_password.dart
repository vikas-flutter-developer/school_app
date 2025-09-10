import 'package:edudibon_flutter_bloc/presentation/password_success_screen/password_success_screen.dart';
import 'package:edudibon_flutter_bloc/presentation/set_new_password/bloc/set_new_password_bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/set_new_password/bloc/set_new_password_event.dart';
import 'package:edudibon_flutter_bloc/presentation/set_new_password/bloc/set_new_password_state.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _passwordError;
  String? _confirmPasswordError;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
    } else if (value.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _confirmPasswordError = 'Confirm password is required';
      });
    } else if (value != _passwordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
    } else {
      setState(() {
        _confirmPasswordError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => NewPasswordBloc(),
        child: BlocConsumer<NewPasswordBloc, NewPasswordState>(
          listener: (context, state) {
            if (state is NewPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password updated successfully!')),
              );
              context.go(AppRoutes.passwordSuccess);
            } else if (state is NewPasswordFailure) {
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
                    'Enter new Password?',
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Set new password',
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: (value) {
                      _validatePassword(value);
                      context.read<NewPasswordBloc>().add(NewPasswordChanged(value));
                    },
                    obscureText: _obscurePassword,
                    style: GoogleFonts.openSans(fontSize: screenWidth * 0.045),
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: GoogleFonts.openSans(fontSize: screenWidth * 0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      errorText: _passwordError,
                      errorStyle: GoogleFonts.openSans(fontSize: screenWidth * 0.035, color: Colors.redAccent),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade600,
                          size: screenWidth * 0.06,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TextFormField(
                    controller: _confirmPasswordController,
                    onChanged: (value) {
                      _validateConfirmPassword(value);
                      context.read<NewPasswordBloc>().add(ConfirmPasswordChanged(value));
                    },
                    obscureText: _obscureConfirmPassword,
                    style: GoogleFonts.openSans(fontSize: screenWidth * 0.045),
                    decoration: InputDecoration(
                      labelText: 'Confirm new password',
                      labelStyle: GoogleFonts.openSans(fontSize: screenWidth * 0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      errorText: _confirmPasswordError,
                      errorStyle: GoogleFonts.openSans(fontSize: screenWidth * 0.035, color: Colors.redAccent),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade600,
                          size: screenWidth * 0.06,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  ElevatedButton(
                    onPressed: state is NewPasswordLoading ||
                        _passwordError != null ||
                        _confirmPasswordError != null
                        ? null
                        : ()=>context.go(AppRoutes.passwordSuccess),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(double.infinity, screenHeight * 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    ),
                    child: state is NewPasswordLoading
                        ? SizedBox(
                      height: screenHeight * 0.03,
                      width: screenHeight * 0.03,
                      child: const CircularProgressIndicator(color: Colors.white),
                    )
                        : Text(
                      'Done',
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