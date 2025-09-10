import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../widgets/study_material_widgets/subject_card.dart';
import 'bloc/see_more_bloc.dart';
import 'bloc/see_more_event.dart';
import 'bloc/see_more_state.dart';
import 'model/study_material_model.dart';
import 'view_more_screen.dart';

class SeeMoreScreen extends StatelessWidget {
  final StudyMaterial subject;

  const SeeMoreScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SeeMoreBloc()..add(LoadMaterials()),
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          title: const Center(child: Text("Study Material")),
          backgroundColor: AppColors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: AppColors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
                vertical: ScreenUtilHelper.scaleHeight(10),
              ),
              child: TextField(
                onChanged: (value) {
                  context.read<SeeMoreBloc>().add(SearchMaterials(value));
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.greyLight, // Your color
                      width: 1.0, // You can set the width too
                    ),),
                  fillColor: AppColors.white,
                  filled: true,
                  hintText: 'Search in ${subject.title}',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.mic),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtilHelper.scaleHeight(12),
                    horizontal: ScreenUtilHelper.scaleWidth(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      ScreenUtilHelper.scaleRadius(8),
                    ),
                  ),
                ),
              ),
            ),

            /// 📝 Header Subtitle
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Text(
                "Download solved question papers",
                style: AppStyles.small.copyWith(color: AppColors.ash),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(5)),

            /// 📝 Header Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Text(
                "Study Material",
                style: AppStyles.headingLarge.copyWith(color: AppColors.black),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),

            /// 📚 Study Material List
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(16),
                ),
                child: BlocBuilder<SeeMoreBloc, SeeMoreState>(
                  builder: (context, state) {
                    if (state is SeeMoreLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SeeMoreLoaded) {
                      return state.materials.isNotEmpty
                          ? ListView.separated(
                        itemCount: state.materials.length,
                        separatorBuilder:
                            (_, __) => SizedBox(
                          height: ScreenUtilHelper.scaleHeight(10),
                        ),
                        itemBuilder: (context, index) {
                          final material = state.materials[index];
                          return SubjectCard(
                            subject: material,
                            buttonText: "View More",
                            onTap:
                                () => context.push(
                              AppRoutes.studyMaterialsDetails,
                              extra: material,
                            ),
                          );
                        },
                      )
                          : Center(
                        child: Text(
                          "No matching results found.",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(18),
                            color: AppColors.error,
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text("Failed to load data."));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}