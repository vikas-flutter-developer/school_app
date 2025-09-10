import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 1. Add the import for your AppColors
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_decorations.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../routes/app_routes.dart';
import 'bloc/study_material_bloc.dart';
import 'bloc/study_material_event.dart';
import 'model/study_material_model.dart';
import 'see_more_screen.dart';
import '../../../widgets/study_material_widgets/subject_card.dart';
import '../../../widgets/study_material_widgets/tab_selector.dart';

class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudyMaterialBloc()..add(LoadStudyMaterials()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              final router = GoRouter.of(context);
              if (router.canPop()) {
                router.pop();
              } else {
                router.go(AppRoutes.studentDashboard); // or whatever your dashboard route is
              }
            },
          ),
          title: const Text('Study Material', textAlign: TextAlign.center),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(16),
          ),
          child: Column(
            children: [
              /// 🔍 Search Bar
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtilHelper.scaleHeight(10),
                  bottom: ScreenUtilHelper.scaleHeight(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.mic),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: ScreenUtilHelper.scaleHeight(10),
                      horizontal: ScreenUtilHelper.scaleWidth(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppDecorations.normalRadius,
                      borderSide: const BorderSide(
                        color: AppColors.border, // Standard grey border
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppDecorations.normalRadius,
                      borderSide: const BorderSide(
                        color: AppColors.ash, // Darker grey for focus effect
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: AppDecorations.normalRadius,
                      borderSide: const BorderSide(
                        color: AppColors.border,
                      ),
                    ),
                  ),
                ),
              ),

              /// 🔄 Tab Selector
              Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenUtilHelper.scaleHeight(15),
                ),
                child: const TabSelector(),
              ),

              /// 📚 Subject Cards List
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtilHelper.scaleHeight(10),
                      ),
                      child: SubjectCard(
                        subject: StudyMaterial(title: "Mathematics", details: ""),
                        buttonText: "See More",
                        onTap: () => context.push(AppRoutes.studyMaterialsYears, extra: "Mathematics"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtilHelper.scaleHeight(10),
                      ),
                      child: SubjectCard(
                        subject: StudyMaterial(title: "Physics", details: ""),
                        buttonText: "See More",
                        onTap: () => context.push(AppRoutes.studyMaterialsYears, extra: "Physics"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtilHelper.scaleHeight(10),
                      ),
                      child: SubjectCard(
                        subject: StudyMaterial(title: "Chemistry", details: ""),
                        buttonText: "See More",
                        onTap: () => context.push(AppRoutes.studyMaterialsYears, extra: "Chemistry"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}