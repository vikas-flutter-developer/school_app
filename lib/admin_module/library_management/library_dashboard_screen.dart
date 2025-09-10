import 'package:edudibon_flutter_bloc/admin_module/hrsm/widgets/Custom_logo_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import 'bloc/library_dashboard/library_dashboard_bloc.dart';
import '../../core/utils/screen_util_helper.dart';
import 'models/dashboard_card_item.dart';

class LibraryDashboardScreen extends StatelessWidget {
  const LibraryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryDashboardBloc()..add(LoadDashboard()),
      child: const LibraryDashboardView(),
    );
  }
}

class LibraryDashboardView extends StatelessWidget {
  const LibraryDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocListener<LibraryDashboardBloc, LibraryDashboardState>(
      listener: (context, state) {
        if (state.navigationTarget != null) {
          context.push(state.navigationTarget!);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomLogoAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<LibraryDashboardBloc>().add(LoadDashboard());
            await context.read<LibraryDashboardBloc>().stream.firstWhere(
                  (state) => state.status != DashboardStatus.loading,
            );
          },
          color: AppColors.primaryMedium,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(12),
              vertical: ScreenUtilHelper.height(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ScreenUtilHelper.height(14)),
                Image.asset(
                  'assets/images/library_dashboard.png',
                  height: ScreenUtilHelper.height(139),
                  width: ScreenUtilHelper.width(262),
                  fit: BoxFit.contain,
                ),
                SizedBox(height: ScreenUtilHelper.height(28)),
                BlocBuilder<LibraryDashboardBloc, LibraryDashboardState>(
                  builder: (context, state) {
                    if (state.status == DashboardStatus.loading &&
                        state.items.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(32)),
                        child: const CircularProgressIndicator(
                          color: AppColors.primaryMedium,
                        ),
                      );
                    }

                    if (state.status == DashboardStatus.failure) {
                      return Padding(
                        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(32)),
                        child: Text(
                          "Error: ${state.errorMessage ?? 'Could not load dashboard'}",
                        ),
                      );
                    }

                    if (state.items.isEmpty &&
                        state.status == DashboardStatus.success) {
                      return Padding(
                        padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(32)),
                        child: const Text("No dashboard items found."),
                      );
                    }

                    return Wrap(
                      spacing: ScreenUtilHelper.width(8),
                      runSpacing: ScreenUtilHelper.height(10),
                      alignment: WrapAlignment.center,
                      children: state.items
                          .map((item) =>
                          _buildDashboardCard(context: context, item: item))
                          .toList(),
                    );
                  },
                ),
                SizedBox(height: ScreenUtilHelper.height(28)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required DashboardCardItem item,
  }) {
    final double cardWidth = ScreenUtilHelper.width(110);
    final double cardHeight = ScreenUtilHelper.height(115);
    final double valueFontSize = ScreenUtilHelper.fontSize(22);
    final double iconSize = ScreenUtilHelper.scaleAll(32);
    final double labelFontSize = ScreenUtilHelper.fontSize(11);
    final double secondaryLabelFontSize = ScreenUtilHelper.fontSize(11);

    return InkWell(
      onTap: () => context
          .read<LibraryDashboardBloc>()
          .add(CardTapped(item.navigationRoute)),
      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtilHelper.height(12),
          horizontal: ScreenUtilHelper.width(6),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F4FE),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
          border: Border.all(color: const Color(0xFFD9D4EE), width: 2.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 4.0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (item.value != null)
              Text(
                item.value!,
                style: GoogleFonts.openSans(
                  fontSize: valueFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryMedium,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            else if (item.iconData != null)
              Icon(
                item.iconData,
                size: iconSize,
                color: AppColors.primaryMedium,
              ),
            SizedBox(
              height: ScreenUtilHelper.height(item.value != null ? 6 : 10),
            ),
            Text(
              item.label,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: GoogleFonts.openSans(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
            if (item.secondaryLabel != null)
              Padding(
                padding: EdgeInsets.only(top: ScreenUtilHelper.height(4)),
                child: Text(
                  item.secondaryLabel!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: secondaryLabelFontSize,
                    fontWeight: FontWeight.w500,
                    color: item.secondaryColor ?? AppColors.stone,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
