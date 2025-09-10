import 'dart:convert';
import 'package:edudibon_flutter_bloc/widgets/profile_field_widget.dart'
    show ProfileFieldWidget;
import 'package:edudibon_flutter_bloc/widgets/request_send_bottomsheet.dart'
    show showRequestSentBottomSheet;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http; // Import http package

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/screen_util_helper.dart';
import '../bloc/teacher_edit_profile_bloc.dart';

// Import shared_preferences

class TeacherEditProfileScreen extends StatelessWidget {
  const TeacherEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return BlocProvider(
      create: (context) => TeacherEditProfileBloc(),
      child: const _EditProfileScreenContent(),
    );
  }
}

class _EditProfileScreenContent extends StatelessWidget {
  const _EditProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: ScreenUtilHelper.fontSize(18)), // ScreenUtilHelper
        ),
        centerTitle: true,
        actions: const [Icon(Icons.notifications_none)],
      ),
      body: BlocListener<TeacherEditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            showRequestSentBottomSheet(context);
          }
          if (state is EditProfileFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: const _EditProfileForm(),
      ),
    );
  }
}

class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm();

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  Map<String, String> _profileData = {}; // Initialize as empty
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // Fetch data when the widget initializes
  }

  // Future<String?> _getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('authToken'); // Replace 'authToken' with your key
  // }
  //
  Future<void> _fetchProfileData() async {
    final String apiUrl =
        'https://stage-api-edudibon.trinodepointers.com/core/student/info';
    // final String? token = await _getToken();

    // if (token == null) {
    //   setState(() {
    //     _isLoading = false;
    //     _errorMessage = 'Authentication token not found.';
    //   });
    //   return;
    // }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuczEyNWF6MjdtZ3UiLCJuYW1lIjoiQXpoYWdpIEsiLCJ0eiI6IkFzaWEvS29sa2F0YSIsImlhdCI6MTc0NTQ4MDM5NCwiZXhwIjoxNzQ1NTEzOTk0LCJhdWQiOiJlZHVESUJPTiIsImlzcyI6Imh0dHBzOi8vc3RhZ2UtZWR1ZGlib24udHJpbm9kZXBvaW50ZXJzLmNvbSIsImRhdGEiOiJnQUFBQUFCb0NlckswV2lQeDhYTnlDQlVXdWRRSXZzV0dDdFNoa3haSEdaWXpNNWx1NlROa1I3QVpOS1UxYkZLS09qWVR0bEw3bmpfVVVqNlEyZDBUUDZNcDVrTXhyNWdZMFN1bmstcnZMdDM0TUQ3aDRqbkY1RGFlMVBzNjlOa0s5bUJ2b0NTRWxrdl9nWklkdUNXbVRXOWs2TjQwQmNrd0gwT0VFZjJ6U1BUT0U4dE5ScGVzZTJ3LWNILWxUU21nNDJMbk81OS1HRE0ifQ.X1kL72b25GCjWTX_gY-BjGRhiH1V9CaxqywTV3XvwH0',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(
          response.body,
        ); // Decode the response
        final Map<String, dynamic> data =
            responseData['data']; // Access the 'data' part

        setState(() {
          _isLoading = false;
          _profileData = {
            'Student Name': data['name'] ?? 'N/A',
            'Father Name': data['father_name'] ?? 'N/A', // Adjust key if needed
            'DOB': data['dob'] ?? 'N/A',
            'Email Id': data['email'] ?? 'N/A', // Adjust key if needed
            'Mobile number':
                data['mobile_number'] ?? 'N/A', // Adjust key if needed
            'Blood Group': data['blood_group'] ?? 'N/A',
            'Gender': data['gender'] ?? 'N/A',
            'Address': data['address'] ?? 'N/A', // Adjust key if needed
          };
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Failed to fetch profile data. Status code: ${response.statusCode}';
        });
        print(
          'Failed to fetch profile data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching profile data: $e';
      });
      print('Error fetching profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    return Padding(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), // ScreenUtilHelper
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._profileData.entries.map(
            (entry) => ProfileFieldWidget(label: entry.key, value: entry.value),
          ),
          _buildSendRequestButton(context),
        ],
      ),
    );
  }

  Widget _buildSendRequestButton(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () => _sendProfileUpdateRequest(context),
        child: Text(
          'Send request',
          style: TextStyle(
            color: AppColors.info,
            fontSize: ScreenUtilHelper.fontSize(14), // ScreenUtilHelper
          ),
        ),
      ),
    );
  }

  void _sendProfileUpdateRequest(BuildContext context) async {
    // No need to pass _profileData here, the bloc will handle fetching it again if needed
    context.read<TeacherEditProfileBloc>().add(
      SendProfileUpdateRequest(_profileData),
    );
  }
}
