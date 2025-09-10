import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/notification_button.dart';
import '../bloc/communication_bloc.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class CommunicationManagementScreen extends StatelessWidget {
  const CommunicationManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CommunicationBloc()..add(LoadCommunicationOptions()),
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
        body: BlocBuilder<CommunicationBloc, CommunicationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/comms_dashbaord.png',
                        height: ScreenUtilHelper.scaleHeight(200),
                      ),
                      Column(
                        children: [
                          Text(
                            'Communication',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtilHelper.scaleText(18),
                              color:AppColors.primaryDark
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Management',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtilHelper.scaleText(18),
                                color:AppColors.primaryDark
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(32)),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: ScreenUtilHelper.scaleWidth(16),
                    mainAxisSpacing: ScreenUtilHelper.scaleHeight(16),
                    childAspectRatio: 1.1,
                    children: [
                      _buildOptionCard(
                        context,
                        'assets/images/sms.png',
                        'Sms',()=>context.push(AppRoutes.teacherSms),
                      ),
                      _buildOptionCard(
                        context,
                        'assets/images/mail.png',
                        'E-mail',()=>context.push(AppRoutes.teacherMail),
                      ),
                      _buildOptionCard(
                        context,
                        'assets/images/notices.png',
                        'Notices',
                            ()=>context.push(AppRoutes.teacherNotices),
                      ),
                      _buildOptionCard(
                        context,
                        'assets/images/support.png',
                        'Support',
                        ()=>context.push(AppRoutes.teacherSupport),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: AppColors.white,
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context,
      String image,
      String label,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(5)),
          border: Border.all(color: AppColors.cloud,width: 1),
          color: AppColors.secondaryAccentLight.withOpacity(0.2),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            // Icon(
            //   icon,
            //   size: ScreenUtilHelper.scaleWidth(40),
            //   color: AppColors.black,
            //   // color: Theme.of(context).primaryColor,
            // ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: ScreenUtilHelper.scaleText(16),
              ),
            ),
          ],
        ),
      )
    );
  }
}
