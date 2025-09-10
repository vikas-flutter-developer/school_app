import 'package:edudibon_flutter_bloc/student_module/Syllabus&Assignment&homework/science_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';

import '../../routes/app_routes.dart';
import 'bloc/syllabus_bloc.dart';
import 'bloc/syllabus_event.dart';
import 'bloc/syllabus_state.dart';
import 'chemicalBond_screen.dart';
import 'custom/syllabus_card.dart';
import 'mathematics_screen.dart';

class SyllabusSearchScreen extends StatelessWidget {
  const SyllabusSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SyllabusBloc()..add(LoadInitialSyllabus()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
          elevation: 0, // Removed shadow to match screenshot
          automaticallyImplyLeading: false,

          // === AppBar UPDATE: Logo ko leading mein daala gaya hai ===
          leadingWidth: ScreenUtilHelper.scaleWidth(120),
          leading: Padding(
            padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
            child: Image.asset(
              'assets/images/edudibon.png',
              fit: BoxFit.contain,
            ),
          ),

          actions: [
            // === AppBar UPDATE: Notification icon ko badge ke saath banaya gaya hai ===
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none_outlined, size: ScreenUtilHelper.scaleWidth(30), color: AppColors.black),
                  onPressed: () {
                    // Handle notification icon tap
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === BODY UPDATE: 'Syllabus List' header add kiya gaya hai ===
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
                    onPressed: () {
                      final router = GoRouter.of(context);
                      if (router.canPop()) {
                        router.pop();
                      } else {
                        router.go('/student'); // or whatever your dashboard route is
                      }
                    },
                  ),
                  Text(
                    "Syllabus List",
                    style: AppStyles.heading.copyWith(fontSize: ScreenUtilHelper.scaleText(18)),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(10)),

              TextField(
                style: TextStyle(fontSize: ScreenUtilHelper.scaleText(14)),
                decoration: InputDecoration(
                  hintText: 'Search.....',
                  fillColor: AppColors.greyLight, // Added light grey background
                  filled: true,
                  hintStyle: TextStyle(fontSize: ScreenUtilHelper.scaleText(14), color: AppColors.ash),
                  prefixIcon: Icon(Icons.search, size: ScreenUtilHelper.scaleWidth(24)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.mic, size: ScreenUtilHelper.scaleWidth(24)),
                    onPressed: () {
                      // Handle mic tap
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: AppDecorations.normalRadius,
                    borderSide: BorderSide.none, // Removed border to match screenshot
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtilHelper.scaleHeight(12),
                    horizontal: ScreenUtilHelper.scaleWidth(12),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
              Expanded(
                child: BlocBuilder<SyllabusBloc, SyllabusState>(
                  builder: (context, state) {
                    if (state is SyllabusLoaded && state.syllabusList.isNotEmpty) {
                      return ListView(
                        children: state.syllabusList.map((syllabus) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(12)),
                            child: SyllabusCard(
                              heading: syllabus,
                              description:
                              'Lorem Ipsum is Simply Dummy Text Of \nThe Printing And Typesetting Industry...',
                              onViewMorePressed: () {
                                if (syllabus == "Chemical Bonds") {
                                  context.push(AppRoutes.syllabusChemistry);
                                } else if (syllabus == "Science") {
                                  context.push(AppRoutes.syllabusScience);
                                } else if (syllabus == "Mathematics") {
                                  context.push(AppRoutes.syllabusMath);
                                }
                              },
                              backgroundColor: syllabus == "Chemical Bonds"
                                  ? AppColors.primaryLavender
                                  : syllabus == "Science"
                                  ? AppColors.chapterTile2Bg
                                  : AppColors.chapterTile3Bg,
                            ),
                          );
                        }).toList(),
                      );
                    } else if (state is SyllabusLoaded && state.syllabusList.isEmpty) {
                      return Center(
                        child: Text(
                          'No syllabus found',
                          style: AppStyles.bodyEmphasis.copyWith(
                            fontSize: ScreenUtilHelper.scaleText(14),
                          ),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}