import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_decorations.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'bloc/view_more_bloc.dart';
import 'bloc/view_more_event.dart';
import 'bloc/view_more_state.dart';
import 'download_screen.dart';
import 'model/study_material_model.dart';
import 'package:edudibon_flutter_bloc/widgets/study_material_widgets/subject_card.dart';

class ViewMoreScreen extends StatelessWidget {
  final StudyMaterial subject;

  const ViewMoreScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewMoreBloc()..add(LoadViewMoreMaterials()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Center(
            child: Text(
              "Study Material",
              style: TextStyle(fontSize: ScreenUtilHelper.scaleText(16)),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtilHelper.scaleWidth(20),
            ),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                size: ScreenUtilHelper.scaleWidth(24),
              ),
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
              child: SizedBox(
                height: ScreenUtilHelper.scaleHeight(47),
                child: TextField(
                  onChanged: (value) {
                    context.read<ViewMoreBloc>().add(
                      SearchViewMoreMaterials(value),
                    );
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyLight, // Your color
                        width: 1.0, // You can set the width too
                      ),
                    ),
                    hintText: 'Search in ${subject.title}',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.mic),
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleRadius(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// 📝 Subtitle
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Text(
                "Download solved question papers",
                style: AppStyles.small.copyWith(
                  color: AppColors.ash,
                  fontSize: ScreenUtilHelper.scaleText(12),
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(5)),

            /// 📝 Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Text(
                "Study Material",
                style: AppStyles.headingLarge.copyWith(
                  fontSize: ScreenUtilHelper.scaleText(18),
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),

            /// 📚 Study Material List
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(16),
                ),
                child: BlocBuilder<ViewMoreBloc, ViewMoreState>(
                  builder: (context, state) {
                    if (state is ViewMoreLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ViewMoreLoaded) {
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
                                buttonText: "Download",
                                onTap:
                                    () => context.push(
                                      AppRoutes.materialDownload,
                                      extra: {
                                        "subjectTitle": subject.title,
                                        "materialTitle": material.title,
                                      },
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
