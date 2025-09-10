import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../widgets/profile_field_widget.dart';
import '../bloc/edit_profile_bloc.dart';
import 'dailog_box.dart';
// मैंने मान लिया है कि आपकी बॉटम शीट का नाम 'success_bottom_sheet.dart' है

class StudentEditProfileScreen extends StatelessWidget {
  const StudentEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: const _EditProfileScreenContent(),
    );
  }
}

class _EditProfileScreenContent extends StatelessWidget {
  const _EditProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text('Edit Profile'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is EditProfileSuccess) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            // यह नीचे से आने वाला Bottom Sheet कॉल करेगा
            showSuccessBottomSheet(context);

          } else if (state is EditProfileFailure) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: const _EditProfileForm(),
      ),
    );
  }
}

// ===================================================================
// >> यहाँ बदलाव किया गया है <<
// ===================================================================
class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm({super.key});

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  final Map<String, String> _profileData = {
    'Student Name': 'NAVEEN NAVEEN',
    'Father Name': 'Naveen B',
    'DOB': '05/11/1998',
    'Email Id': 'nabeen1234@gmail.com',
    'Mobile number': '9090909090',
    'Blood Group': 'O +ve',
    'Gender': 'Male',
    'Address': 'C/o 342, D.P Nagar, Bengaluru, KA-560000',
  };

  @override
  Widget build(BuildContext context) {
    // Column और Expanded को हटाकर सीधे ListView का उपयोग किया गया है
    return Padding(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
      child: ListView(
        children: [
          // सारे प्रोफाइल फील्ड्स पहले दिखाए जायेंगे
          ..._profileData.entries.map(
                (entry) => ProfileFieldWidget(
              label: entry.key,
              value: entry.value,
            ),
          ),

          // एड्रेस फील्ड और बटन के बीच में स्पेस
          SizedBox(height: ScreenUtilHelper.scaleHeight(40)),

          // अब बटन लिस्ट का ही हिस्सा है, इसलिए यह एड्रेस के ठीक नीचे आएगा
          _buildSendRequestButton(context),
        ],
      ),
    );
  }

  // इस फंक्शन में कोई बदलाव नहीं
  Widget _buildSendRequestButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: ScreenUtilHelper.scaleHeight(32),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
            ),
          ),
          onPressed: () => _sendProfileUpdateRequest(context),
          child: Text(
            'Send request',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: ScreenUtilHelper.scaleText(14),
            ),
          ),
        ),
      ),
    );
  }

  // इस फंक्शन में कोई बदलाव नहीं
  void _sendProfileUpdateRequest(BuildContext context) {
    context.read<EditProfileBloc>().add(SendProfileUpdateRequest(_profileData));
  }
}