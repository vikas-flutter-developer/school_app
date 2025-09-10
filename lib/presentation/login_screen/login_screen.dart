import 'package:edudibon_flutter_bloc/presentation/login_screen/bloc/login_bloc.dart';
import 'package:edudibon_flutter_bloc/presentation/login_screen/bloc/login_event.dart';
import 'package:edudibon_flutter_bloc/presentation/login_screen/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() => _isLoading = true);
        } else if (state is LoginSuccess) {
          setState(() => _isLoading = false);
          // context.go(AppRoutes.adminDashboard);
        } else if (state is LoginFailure) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.48,
            width: screenWidth,
            color: Colors.white,
            padding: EdgeInsets.only(top: screenHeight * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/img.png',
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.55,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.08),
                  child: Text(
                    'Welcome',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.08),
                  child: Text(
                    'Login to continue',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.openSans(
                      color: Color(0xff6E69C5),
                      fontStyle: FontStyle.normal,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff4169B9),
                          Color(0xffDCECFF),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildInputField(
                        controller: _emailController,
                        labelText: 'Mobile Number / Email',
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      _buildPasswordField(
                        controller: _passwordController,
                        lableText: 'Password',
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: ()=>context.push(AppRoutes.forgotPassword),
                          child: Text(
                            'Forgot Password ?',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.035),
                      SizedBox(
                        width: screenWidth * 0.8,
                        child: _buildLoginButton(context),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            context.push(AppRoutes.otpLogin);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'No Password ?',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: screenWidth * 0.035,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Login Using OTP',
                                  style: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// ... (rest of your _buildInputField, _buildPasswordField, _buildLoginButton methods)
  Widget _buildInputField({
    required TextEditingController controller,
    //required String hintText,
    required String labelText,
    //required IconData icon,
  }) {
    return Container(
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04), // Responsive font size
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Colors.white.withOpacity(0.7)), // Responsive label size
          //hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.7), fontSize: MediaQuery.of(context).size.width * 0.04), // Responsive font size
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
          /*prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 10.0),
            child: Icon(icon, color: Colors.white.withOpacity(0.7), size: 24),
          ),*/
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    //required String hintText,
    required String lableText,
  }) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: _obscurePassword,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04), // Responsive font size
        decoration: InputDecoration(
          labelText: lableText,
          labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, color: Colors.white.withOpacity(0.7)), // Responsive label size
          //hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.7), fontSize: MediaQuery.of(context).size.width * 0.04), // Responsive font size
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
          /*prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 10.0),
            child: Icon(Icons.lock_outline,
                color: Colors.white.withOpacity(0.7), size: 24),
          ),*/
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.white.withOpacity(0.7),
              size: 24,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
          if (_emailController.text.isEmpty ||
              _passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please fill all fields')),
            );
            return;
          }
          context.read<LoginBloc>().add(
            LoginButtonPressed(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff4169B9),
          minimumSize: Size(double.infinity, 50), // Responsive button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: _isLoading
            ? SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        )
            : Text(
          'Log in',
          style: GoogleFonts.openSans(
            color: Color(0xffFFFFFF),
            fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}