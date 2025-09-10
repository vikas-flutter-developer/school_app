import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../widgets/email_list_item.dart';
import '../bloc/email_list/email_list_bloc.dart';
import 'email_compose_screen.dart';

class EmailListScreen extends StatelessWidget {
  const EmailListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailListBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text(
            'Emails',
            style: TextStyle(fontSize: ScreenUtilHelper.scaleText(18)),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Optional: Add menu logic
              },
            ),
          ],
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 1,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for Emails...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                    borderSide: BorderSide(color: AppColors.cloud),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                    borderSide: BorderSide(color: AppColors.cloud),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  filled: true,
                  fillColor: AppColors.linen,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(16),
                  ),
                ),
                onChanged: (value) {
                  context.read<EmailListBloc>().add(SearchEmailsChanged(value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<EmailListBloc, EmailListState>(
                builder: (context, state) {
                  if (state.status == EmailListStatus.loading && state.emails.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == EmailListStatus.failure) {
                    return Center(
                      child: Text('Error loading emails: ${state.error}'),
                    );
                  }
                  if (state.emails.isEmpty) {
                    return const Center(child: Text('No emails found.'));
                  }

                  return ListView.builder(
                    itemCount: state.emails.length,
                    itemBuilder: (context, index) {
                      final email = state.emails[index];
                      final bool isSelected = index == 1; // Sample selected index
                      return EmailListItem(
                        email: email,
                        isSelected: isSelected,
                        onTap: () {
                          // Navigate to Email Detail Screen if needed
                        },
                        onMenuTap: () => _showEmailOptions(context, email.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=>context.go(AppRoutes.teacherMailCompose),
          icon: Icon(Icons.edit_outlined, size: ScreenUtilHelper.scaleWidth(22)),
          label: Text(
            'Compose',
            style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
          ),
          backgroundColor: AppColors.secondaryAccentLight,
          foregroundColor: AppColors.tertiaryDarker,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(16)),
          ),
        ),
        backgroundColor: AppColors.white,
      ),
    );
  }

  void _showEmailOptions(BuildContext context, String emailId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete'),
                onTap: () {
                  GoRouter.of(context).pop();
                  context.read<EmailListBloc>().add(DeleteEmail(emailId));
                },
              ),
              // More options if needed
            ],
          ),
        );
      },
    );
  }
}
