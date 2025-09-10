import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/complains_bloc/complains_bloc.dart';
import '../models/complaint_model.dart';
import 'complaint_list_item.dart';

class StudentTabContent extends StatelessWidget {
  const StudentTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocBuilder<ComplainsBloc, ComplainsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.studentComplaints.isEmpty) {
          return const Center(child: Text('No complaints found.'));
        }
        return Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.width(16.0)),
          child: ListView.builder(
            itemCount: state.studentComplaints.length,
            itemBuilder: (context, index) {
              final ComplaintModel complaint = state.studentComplaints[index];
              return ComplaintListItem(complaint: complaint);
            },
          ),
        );
      },
    );
  }
}