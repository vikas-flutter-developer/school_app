// sms_list_screen.dart
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:edudibon_flutter_bloc/teacher_module/communication/features/sms/screens/sms_chat_screen.dart'
    show SmsChatScreen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../widgets/sms_list_item.dart';
import '../bloc/sms_list/sms_list_bloc.dart'; // Import Chat Screen

class SmsListScreen extends StatefulWidget {
  const SmsListScreen({Key? key}) : super(key: key);

  @override
  State<SmsListScreen> createState() => _SmsListScreenState();
}

class _SmsListScreenState extends State<SmsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<SmsListBloc>().add(SwitchSmsTab(_tabController.index));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create:
          (context) =>
              SmsListBloc()..add(const LoadSmsConversations(isIncoming: true)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: AppColors.blackHighEmphasis,
            ),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: const Text('Add Recipients'),
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0)),
              decoration: BoxDecoration(
                color: AppColors.tertiaryLightest,
                borderRadius: BorderRadius.circular(
                  ScreenUtilHelper.scaleRadius(8.0),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.transparent,
                dividerColor: AppColors.transparent,
                labelColor: AppColors.primaryDarker,
                unselectedLabelColor: AppColors.black,
                tabs: const [Tab(text: 'Incoming'), Tab(text: 'Outgoing')],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic),
                          onPressed: () {
                            /* Handle Mic tap */
                          },
                        ),
                        border: OutlineInputBorder(
                          // borderSide: BorderSide(color: AppColors.ash,width: 1),
                          borderRadius: BorderRadius.circular(
                            ScreenUtilHelper.scaleRadius(30.0),
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: ScreenUtilHelper.scaleWidth(16),
                        ),
                      ),
                      onChanged: (value) {
                        // context.read<SmsListBloc>().add(SearchSmsChanged(value));
                      },
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                  const Text('Select All'),
                  BlocBuilder<SmsListBloc, SmsListState>(
                    builder: (context, state) {
                      bool isAllSelected =
                          state.conversations.isNotEmpty &&
                          state.selectedIds.length ==
                              state.conversations.length;
                      bool isIndeterminate =
                          state.selectedIds.isNotEmpty && !isAllSelected;

                      return Checkbox(
                        value: isAllSelected,
                        tristate: isIndeterminate,
                        onChanged: (bool? value) {
                          context.read<SmsListBloc>().add(ToggleSelectAllSms());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SmsListBloc, SmsListState>(
                builder: (context, state) {
                  if (state.status == SmsListStatus.loading &&
                      state.conversations.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == SmsListStatus.failure) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state.conversations.isEmpty) {
                    return Center(
                      child: Text(
                        'No ${state.isIncomingTab ? 'incoming' : 'outgoing'} messages.',
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = state.conversations[index];
                      final isSelected = state.selectedIds.contains(
                        conversation.id,
                      );
                      return SmsListItem(
                        conversation: conversation,
                        isSelected: isSelected,
                        onTap:
                            () => context.push(
                              AppRoutes.teacherSmsChat,
                              extra: conversation,
                            ),
                        onLongPress: () {
                          context.read<SmsListBloc>().add(
                            ToggleSelectSmsItem(conversation.id),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<SmsListBloc, SmsListState>(
          builder: (context, state) {
            if (state.selectedIds.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  /* Action for selected */
                },
                child: const Icon(Icons.delete_outline),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenUtilHelper.scaleHeight(16.0),
                  right: ScreenUtilHelper.scaleWidth(8.0),
                ),
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    if (state.selectedIds.length == 1) {
                      final selectedConv = state.conversations.firstWhere(
                        (c) => c.id == state.selectedIds.first,
                      );
                      context.push(
                        AppRoutes.teacherSmsChat,
                        extra: selectedConv,
                      );
                      ;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select exactly one conversation.',
                          ),
                        ),
                      );
                    }
                  },
                  backgroundColor:AppColors.primaryMedium,
                  child: const Icon(Icons.message_outlined,color: AppColors.white,),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
