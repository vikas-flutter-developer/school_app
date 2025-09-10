import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/email_compose/email_compose_bloc.dart';

class EmailComposeScreen extends StatefulWidget {
  const EmailComposeScreen({super.key});

  @override
  State<EmailComposeScreen> createState() => _EmailComposeScreenState();
}

class _EmailComposeScreenState extends State<EmailComposeScreen> {
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailComposeBloc(),
      child: BlocConsumer<EmailComposeBloc, EmailComposeState>(
        listener: (context, state) {
          if (state.status == EmailComposeStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Email sent successfully!'),
                backgroundColor: AppColors.successAccent,
              ),
            );
            GoRouter.of(context).pop();
          }
          if (state.status == EmailComposeStatus.failure && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (_subjectController.text != state.subject) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _subjectController.text = state.subject;
            });
          }
          if (_bodyController.text != state.body) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _bodyController.text = state.body;
            });
          }

          return Scaffold(
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
                if (state.status == EmailComposeStatus.sending)
                  Padding(
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                    child: SizedBox(
                      width: ScreenUtilHelper.scaleWidth(20),
                      height: ScreenUtilHelper.scaleWidth(20),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: () => context.read<EmailComposeBloc>().add(SendEmail()),
                  ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              // elevation: 1,
            ),
            body: state.status == EmailComposeStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdown(
                    context: context,
                    label: 'From :',
                    value: state.selectedFrom,
                    items: state.fromOptions,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<EmailComposeBloc>().add(SenderSelected(value));
                      }
                    },
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  _buildRecipientSelector(context, state),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  TextField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(12),
                        vertical: ScreenUtilHelper.scaleHeight(10),
                      ),
                    ),
                    onChanged: (value) =>
                        context.read<EmailComposeBloc>().add(SubjectChanged(value)),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  TextField(
                    controller: _bodyController,
                    decoration: InputDecoration(
                      labelText: 'Compose email',
                      hintText: 'Write your message here...',
                      border: const OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilHelper.scaleWidth(12),
                        vertical: ScreenUtilHelper.scaleHeight(10),
                      ),
                    ),
                    maxLines: 10,
                    minLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) =>
                        context.read<EmailComposeBloc>().add(BodyChanged(value)),
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.white,
          );
        },
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(12),
          vertical: ScreenUtilHelper.scaleHeight(10),
        ),
      ),
    );
  }

  Widget _buildRecipientSelector(BuildContext context, EmailComposeState state) {
    return InkWell(
      onTap: () => _showRecipientSelectionDialog(context, state),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'To',
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(12),
            vertical: ScreenUtilHelper.scaleHeight(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.selectedRecipientGroupIds.isEmpty
                  ? 'Select recipients'
                  : '${state.selectedRecipientGroupIds.length} group(s) selected',
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(14),
                color: state.selectedRecipientGroupIds.isEmpty
                    ? AppColors.blackHighEmphasis
                    : AppColors.black,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.ash),
          ],
        ),
      ),
    );
  }

  void _showRecipientSelectionDialog(
      BuildContext parentContext, EmailComposeState currentState) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Set<String> currentDialogSelection =
            Set.from(currentState.selectedRecipientGroupIds);

            return AlertDialog(
              title: Text('Select Recipient Groups',
                  style: TextStyle(fontSize: ScreenUtilHelper.scaleText(16))),
              contentPadding:
              EdgeInsets.only(top: ScreenUtilHelper.scaleHeight(12)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: currentState.availableRecipientGroups.map((group) {
                    IconData icon = Icons.people_outline;
                    if (group.name.startsWith('All')) {
                      icon = Icons.group_work_outlined;
                    } else if (group.name.contains('list')) {
                      icon = Icons.list_alt_outlined;
                    }

                    return CheckboxListTile(
                      secondary: Icon(icon, color: AppColors.slate),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(group.name),
                      value: currentDialogSelection.contains(group.id),
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            currentDialogSelection.add(group.id);
                          } else {
                            currentDialogSelection.remove(group.id);
                          }
                        });
                        parentContext
                            .read<EmailComposeBloc>()
                            .add(RecipientGroupToggled(group.id, value ?? false));
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Done'),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
