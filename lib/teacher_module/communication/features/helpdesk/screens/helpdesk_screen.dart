// helpdesk_screen.dart
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/notification_button.dart';
import '../bloc/helpdesk/helpdesk_bloc.dart';
import 'create_ticket_screen.dart';

class TeacherHelpdeskScreen extends StatelessWidget {
  const TeacherHelpdeskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocProvider(
      create: (context) => TeacherHelpdeskBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.blackHighEmphasis,size: 24,),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.width(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/edudibon_logo.png',
                  height: ScreenUtilHelper.height(30),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>context.push(AppRoutes.notifications),
                  child: Image.asset(
                    'assets/images/notification.png',
                    height: ScreenUtilHelper.height(24),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.white,
          // elevation: 1.0,
        ),
        body: BlocBuilder<TeacherHelpdeskBloc, HelpdeskState>(
          builder: (context, state) {
            if (state.status == HelpdeskStatus.loading && state.faqItems.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == HelpdeskStatus.failure && state.faqItems.isEmpty) {
              return Center(
                child: Text('Error loading helpdesk data: ${state.error}'),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.mic,color: AppColors.ash,),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.cloud,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: ScreenUtilHelper.scaleWidth(16),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<TeacherHelpdeskBloc>().add(SearchHelpdeskChanged(value));
                    },
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(24)),

                  Container(
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
                      color: AppColors.primaryMedium.withAlpha(40),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Helpdesk',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 2,
                          crossAxisSpacing: ScreenUtilHelper.scaleWidth(16),
                          mainAxisSpacing: ScreenUtilHelper.scaleHeight(16),
                          children: [
                            _buildStatCard(context, state.stats.allQueries, 'All Queries'),
                            _buildStatCard(context, state.stats.open, 'Open'),
                            _buildStatCard(context, state.stats.closed, 'Closed'),
                            _buildStatCard(context, state.stats.escalations, 'Escalations'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(24)),

                  Text(
                    'FAQ ?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  if (state.status == HelpdeskStatus.loading)
                    const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()))
                  else if (state.faqItems.isEmpty)
                    const Text('No FAQs found.')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.faqItems.length,
                      itemBuilder: (context, index) {
                        return _buildFaqTile(context, state.faqItems[index]);
                      },
                    ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()=>context.push(AppRoutes.createSupport),
          icon: const Icon(Icons.add),
          label: const Text('Create'),
          backgroundColor: AppColors.primaryMedium,
          foregroundColor: AppColors.white,
        ),
        backgroundColor: AppColors.white,
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, int count, String label) {
    ScreenUtilHelper.init(context);
    return Container(
      height: ScreenUtilHelper.height(100),
      width: ScreenUtilHelper.width(180),
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.blackHighEmphasis,
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.blackHighEmphasis),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFaqTile(BuildContext context, FaqItem faq) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(8)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.silver,width: 1),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)),
      ),
      child: ExpansionTile(
        title: Text(
          faq.question,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: AppStyles.weight.medium),
        ),
        tilePadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(16),
          vertical: ScreenUtilHelper.scaleHeight(4),
        ),
        childrenPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(16),
          vertical: ScreenUtilHelper.scaleHeight(8),
        ).copyWith(top: 0),
        shape: Border.all(color: Colors.transparent, width: 0),
        collapsedShape: Border.all(color: Colors.transparent, width: 0),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              faq.answer,
              style: TextStyle(color: AppColors.slate),
            ),
          ),
        ],
      ),
    );
  }
}
