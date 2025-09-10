import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'bloc/login_with_otp_bloc.dart';

class LoginWithOtpScreen extends StatelessWidget {
  const LoginWithOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const horizontalPadding = 16.0;
    const textFieldHeight = 48.0;
    const buttonHeight = 48.0;
    const buttonVerticalMargin = 24.0;

    return BlocProvider(
      create: (context) => LoginWithOtpBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async{
              _showAlertDialog(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0), // Adjust as needed
              const Text(
                'Login using OTP',
                style: TextStyle(
                  fontSize: 20.0, // Adjust font size for pixel perfection
                  fontWeight: FontWeight.w500, // Adjust font weight
                  color: Colors.black87, // Adjust color
                ),
              ),
              const SizedBox(height: 24.0), // Spacing below the title
              SizedBox(
                height: textFieldHeight,
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 16.0), // Adjust text size
                  decoration: InputDecoration(
                    hintText: 'Mobile no',
                    hintStyle: const TextStyle(fontSize: 16.0, color: Colors.grey), // Adjust hint text style
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0), // Match rounded corners
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Match border color and width
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0), // Focused border color
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0), // Adjust padding
                  ),
                  // onChanged: (value) => context.read<LoginWithOtpBloc>().add(LoginWithOtpTextChanged(userIdMobileNo: value)),
                ),
              ),
              const SizedBox(height: buttonVerticalMargin),
              BlocConsumer<LoginWithOtpBloc, LoginWithOtpState>(
                listener: (context, state) {
                  if (state is LoginWithOtpOTPSent) {
                    // Navigate to the OTP verification screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('OTP Sent (Simulated)')),
                    );
                    context.pushReplacement(AppRoutes.otpVerify);
                  } else if (state is LoginWithOtpError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: screenWidth - 2 * horizontalPadding,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: ()=>context.push(AppRoutes.otpVerify),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C45B5), // Match button color
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Match button rounded corners
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16.0, // Adjust button text size
                          fontWeight: FontWeight.w500, // Adjust button text weight
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0), // Adjust button padding
                      ),
                      child: state is LoginWithOtpLoading
                          ? const SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        ),
                      )
                          : const Text('Next'),
                    ),
                  );
                },
              ),
              // Add more widgets below the button if needed
            ],
          ),
        ),
      ),
    );
  }
}

extension on LoginWithOtpState {
  get userIdMobileNo => null;
}

// --- OTP Verification Screen (Placeholder) ---
// class OtpConfirmationScreen extends StatelessWidget {
//   const OtpConfirmationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Verify OTP')),
//       body: const Center(child: Text('OTP Confirmation Screen')),
//     );
//   }
// }
_showAlertDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // Set the shape of the dialog with rounded corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        // Set the title of the dialog
        title: const Text(
          "Are you sure you want go back?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 'No' button on the left, a simple text button
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              // 'Yes' button on the right, with a filled background
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  context.go(AppRoutes.login);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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