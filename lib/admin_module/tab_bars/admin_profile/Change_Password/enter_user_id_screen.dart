
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import 'bloc/change_password_bloc.dart';
import 'enter_new_password_screen.dart';

class EnterUserIdScreen extends StatefulWidget {
  const EnterUserIdScreen({super.key});

  @override
  State<EnterUserIdScreen> createState() => _EnterUserIdScreenState();
}

class _EnterUserIdScreenState extends State<EnterUserIdScreen> {
  final _userIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    //ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery logic.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: ScreenUtilHelper.scaleAll(20)),
            onPressed: () {
              GoRouter.of(context).pop();
            }
        ),
      ),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordShowNewPasswordScreen) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<ChangePasswordBloc>(context),
                  child: EnterNewPasswordScreen(userId: state.userId),
                ),
              ),
            );
          } else if (state is ChangePasswordUpdateFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error), backgroundColor: AppColors.error));
          }
        },
        builder: (context, state) {
          bool isLoading = state is ChangePasswordUserIdValidationInProgress;
          String? errorMessage;
          String fieldHintText = "Enter User Email Id";
          Color borderColor = AppColors.cloud;

          if (state is ChangePasswordUserIdInvalid) {
            errorMessage = state.error;
            fieldHintText = "Enter correct User Email Id";
            borderColor = AppColors.error;
          }

          return SingleChildScrollView(
            // ✅ Use helper for padding
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(26),
                vertical: ScreenUtilHelper.height(20)
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Password?',
                    style: GoogleFonts.openSans(
                      fontSize: ScreenUtilHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(8)),
                  Text(
                    "Don't worry we are here",
                    style: GoogleFonts.openSans(
                      fontSize: ScreenUtilHelper.fontSize(14),
                      color: AppColors.ash,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(30)),

                  if (errorMessage != null && errorMessage == "Invalid user id")
                    Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(8)),
                      child: Text(
                        errorMessage,
                        style: GoogleFonts.openSans(color: AppColors.error, fontSize: ScreenUtilHelper.fontSize(12)),
                      ),
                    ),

                  TextFormField(
                    controller: _userIdController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: fieldHintText,
                      hintStyle: GoogleFonts.openSans(color: AppColors.ash.withOpacity(0.7)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtilHelper.width(16),
                          vertical: ScreenUtilHelper.height(14)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        borderSide: BorderSide(color: AppColors.primaryMedium.withOpacity(0.8), width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(40)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () {
                        context.read<ChangePasswordBloc>().add(
                          ChangePasswordUserIdSubmitted(_userIdController.text.trim()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryMedium,
                        padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(16)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        ),
                        elevation: 2,
                      ),
                      child: isLoading
                          ? SizedBox(
                        height: ScreenUtilHelper.scaleAll(20),
                        width: ScreenUtilHelper.scaleAll(20),
                        child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
                      )
                          : Text(
                        'Set new password',
                        style: GoogleFonts.openSans(
                          fontSize: ScreenUtilHelper.fontSize(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}