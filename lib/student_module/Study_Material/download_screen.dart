// download_screen.dart

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_decorations.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'bloc/download_bloc.dart';

class DownloadScreen extends StatelessWidget {
  final String subjectName;
  final String academicYear;

  const DownloadScreen({
    super.key,
    required this.subjectName,
    required this.academicYear,
  });

  // ✅ CHANGE 1: Function now accepts the real file path
  void _openDownloadedFile(BuildContext context, String filePath) {
    OpenFile.open(filePath).then((result) {
      if (result.type != ResultType.done) {
        // Optional: Show an error if the file couldn't be opened
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open file: ${result.message}')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DownloadBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: AppDecorations.mediumPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/edudibon.png',
                      height: ScreenUtilHelper.scaleHeight(40),
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications_none_outlined,
                              color: AppColors.black, size: 28),
                          onPressed: () {},
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('3',
                              style:
                              TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: AppColors.black),
                      onPressed: () => GoRouter.of(context).pop(),
                    ),
                    Text(
                      "Quarter Year Exam Paper",
                      style: GoogleFonts.poppins(
                        fontSize: ScreenUtilHelper.scaleText(
                            AppStyles.size.bodyMedium),
                        fontWeight: AppStyles.weight.regular,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
                DottedBorder(
                  color: Colors.blue.shade300,
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(ScreenUtilHelper.scaleRadius(12)),
                  dashPattern: const [8, 4],
                  child: Container(
                    height: ScreenUtilHelper.scaleHeight(200),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius:
                      BorderRadius.circular(ScreenUtilHelper.scaleRadius(12)),
                    ),
                    child: Icon(
                      Icons.file_copy,
                      size: ScreenUtilHelper.scaleWidth(80),
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                BlocConsumer<DownloadBloc, DownloadState>(
                  listener: (context, state) {
                    // ✅ CHANGE 2: Get the filePath from the state and pass it
                    if (state is DownloadCompleted) {
                      _openDownloadedFile(context, state.filePath);
                    }
                    if (state is DownloadCancelled) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text("Download cancelled."),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                    }
                  },
                  builder: (context, state) {
                    return _buildDownloadProgressCard(context, state);
                  },
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

                /// 🔘 Action Buttons
                BlocBuilder<DownloadBloc, DownloadState>(
                  builder: (context, state) {
                    return _buildActionButtons(context, state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadProgressCard(BuildContext context, DownloadState state) {
    double progress = 0.0;
    String statusText = "0% Done";
    String speedText = "0 kb/sec";

    if (state is DownloadInProgress) {
      progress = state.progress;
      statusText = "${(progress * 100).toInt()}% Done";
      speedText = "123 kb/sec";
    } else if (state is DownloadCompleted) {
      progress = 1.0;
      statusText = "Downloaded";
      speedText = "";
    }
    else if (state is DownloadCancelled || state is DownloadInitial) {
      progress = 0.0;
      statusText = "0% Done";
      speedText = "0 kb/sec";
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(12),
        vertical: ScreenUtilHelper.scaleHeight(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDecorations.normalRadius,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_download_outlined,
              color: AppColors.primary, size: 32),
          SizedBox(width: ScreenUtilHelper.scaleWidth(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Science exam paper 01.pdf",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade200,
                  color: AppColors.primary,
                  minHeight: ScreenUtilHelper.scaleHeight(5),
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(height: ScreenUtilHelper.scaleHeight(6)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(statusText,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(speedText,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(12)),
          Icon(Icons.delete_outline, color: Colors.grey.shade600, size: 28),
        ],
      ),
    );
  }

  /// 🔘 Action Buttons
  Widget _buildActionButtons(BuildContext context, DownloadState state) {
    bool isDownloading = state is DownloadInProgress;
    bool isCompleted = state is DownloadCompleted;
    bool isCancelled = state is DownloadCancelled;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: isDownloading
              ? () => context.read<DownloadBloc>().add(CancelDownload())
              : null,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(30),
                vertical: ScreenUtilHelper.scaleHeight(12)),
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
            ),
            disabledForegroundColor: Colors.grey,
          ),
          child: const Text("Cancel"),
        ),
        SizedBox(width: ScreenUtilHelper.scaleWidth(16)),
        ElevatedButton(
          onPressed: isDownloading || isCompleted
              ? null
              : () => context.read<DownloadBloc>().add(StartDownload()),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(30),
                vertical: ScreenUtilHelper.scaleHeight(12)),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: Colors.grey.shade400,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
            ),
          ),
          child: Text(isCompleted ? "Downloaded" : "Download"),
        ),
      ],
    );
  }
}