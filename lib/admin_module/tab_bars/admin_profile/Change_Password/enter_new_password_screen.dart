
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../presentation/password_success_screen/password_success_screen.dart';
import 'bloc/change_password_bloc.dart';


class EnterNewPasswordScreen extends StatefulWidget {
  final String userId;

  const EnterNewPasswordScreen({required this.userId, super.key});

  @override
  State<EnterNewPasswordScreen> createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  // Build password field helper (Now Responsive)
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?)? validator,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.openSans(color: AppColors.ash.withOpacity(0.7)),
        errorText: errorText,
        // ✅ Use helper for padding and radius
        contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),
            vertical: ScreenUtilHelper.height(14)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
          borderSide: BorderSide(color: errorText != null ? AppColors.error : AppColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
          borderSide: BorderSide(color: errorText != null ? AppColors.error : AppColors.primaryMedium.withOpacity(0.8), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.ash,
            size: ScreenUtilHelper.scaleAll(20),
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery logic.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.blackMediumEmphasis, size: ScreenUtilHelper.scaleAll(20)),
            onPressed: () => GoRouter.of(context).pop()
        ),
      ),
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordUpdateSuccess) {
            context.go(AppRoutes.passwordSuccess);
          } else if (state is ChangePasswordUpdateFailure && state.userId == widget.userId) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.error), backgroundColor: AppColors.error));
          }
        },
        builder: (context, state) {
          bool isLoading = state is ChangePasswordUpdateInProgress;
          String? validationError;

          if (state is ChangePasswordNewPasswordValidationFailure && state.userId == widget.userId) {
            validationError = state.error;
          }

          return SingleChildScrollView(
            // ✅ Use helper for padding
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(30),
                vertical: ScreenUtilHelper.height(20)
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter new Password?',
                    style: GoogleFonts.openSans(
                      fontSize: ScreenUtilHelper.fontSize(24),
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackHighEmphasis,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(8)),
                  Text(
                    "Set new password",
                    style: GoogleFonts.openSans(
                      fontSize: ScreenUtilHelper.fontSize(14),
                      color: AppColors.ash,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.height(30)),

                  // New Password Field
                  _buildPasswordField(
                    controller: _newPasswordController,
                    hintText: "New Password",
                    obscureText: _obscureNewPassword,
                    onToggleVisibility: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                    errorText: validationError,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: ScreenUtilHelper.height(20)),

                  // Confirm Password Field
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm new password",
                    obscureText: _obscureConfirmPassword,
                    onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    errorText: validationError,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtilHelper.height(40)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ChangePasswordBloc>().add(
                            ChangePasswordNewPasswordSubmitted(
                              userId: widget.userId,
                              newPassword: _newPasswordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            ),
                          );
                        }
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
                        'Done',
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