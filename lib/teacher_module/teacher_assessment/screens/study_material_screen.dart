import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/custom_filter_row.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/custom_search_bar.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/widgets/study_material_item.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/study_material/study_material_bloc.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/bloc/study_material/study_material_event.dart';

class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StudyMaterialsBloc()..add(LoadStudyMaterials()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
            const CustomSearchBar(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
            const StudyMaterialFilterRow(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
            const MaterialTypeChips(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(25)),
            Expanded(
              child: BlocBuilder<StudyMaterialsBloc, StudyMaterialsState>(
                builder: (context, state) {
                  if (state is StudyMaterialLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudyMaterialError) {
                    return Center(child: Text(state.message));
                  } else if (state is StudyMaterialLoaded) {
                    final filteredMaterials = state.materials.where((material) {
                      if (state.selectedType == 'All') return true;
                      return material.type == state.selectedType.toLowerCase();
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredMaterials.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: ScreenUtilHelper.scaleHeight(30)),
                        child: StudyMaterialItem(material: filteredMaterials[index]),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyMaterialFilterRow extends StatelessWidget {
  const StudyMaterialFilterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomFilterButton(),
        SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
        _buildDropdown(context, 'Subject'),
        SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
        _buildDropdown(context, 'class'),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context, String text) {
    return InkWell(
      onTap: () => _handleDropdownTap(context, text),
      child: Container(
        width: ScreenUtilHelper.scaleWidth(94),
        height: ScreenUtilHelper.scaleHeight(28),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
        decoration: BoxDecoration(
          color: AppColors.linen,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text, style: AppStyles.font14),
            const Icon(Icons.arrow_drop_down, size: 20.0),
          ],
        ),
      ),
    );
  }

  void _handleDropdownTap(BuildContext context, String filterType) {
    context.read<StudyMaterialsBloc>().add(
      FilterStudyMaterials(
        subject: filterType == 'Subject' ? 'Science' : null,
        classFilter: filterType == 'class' ? '10' : null,
      ),
    );
  }
}

class MaterialTypeChips extends StatelessWidget {
  const MaterialTypeChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const chipLabels = ['All', 'Pdf', 'Books', 'PPT', 'Notes'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chipLabels.map((label) {
          return Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.scaleWidth(7)),
            child: BlocBuilder<StudyMaterialsBloc, StudyMaterialsState>(
              builder: (context, state) {
                final isSelected =
                    state is StudyMaterialLoaded && state.selectedType == label;

                return GestureDetector(
                  onTap: () {
                    context.read<StudyMaterialsBloc>().add(ChangeMaterialType(label));
                  },
                  child: Container(
                    width: ScreenUtilHelper.scaleWidth(80),
                    height: ScreenUtilHelper.scaleHeight(30),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryMedium : AppColors.ivory,
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(6)),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: AppStyles.selectable(isSelected),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
