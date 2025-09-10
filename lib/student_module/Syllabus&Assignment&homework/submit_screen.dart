import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_decorations.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  bool dontAskAgain = false;
  bool fileSelected = false;
  String selectedAppName = '';

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: ScreenUtilHelper.scaleWidth(120),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(12)),
          child: Image.asset(
            'assets/images/edudibon.png',
            height: ScreenUtilHelper.scaleHeight(50),
            width: ScreenUtilHelper.scaleWidth(100),
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, size: ScreenUtilHelper.scaleWidth(24)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleWidth(20)),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
                Text(
                  'Assignment',
                  style: AppStyles.heading,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
            child: DottedBorder(
              color: AppColors.tertiary,
              strokeWidth: 1,
              dashPattern: [6, 3],
              child: Container(
                width: double.infinity,
                height: ScreenUtilHelper.scaleHeight(200),
                color: AppColors.ivory,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/upload.png',
                      width: ScreenUtilHelper.scaleWidth(40),
                      height: ScreenUtilHelper.scaleHeight(40),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                    Text('Upload here'),
                  ],
                ),
              ),
            ),
          ),
          if (!fileSelected)
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showOpenWithBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryMedium,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDecorations.normalRadius,
                    ),
                  ),
                  child: Text('Upload File'),
                ),
              ),
            ),
          if (fileSelected)
            Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(12)),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppDecorations.normalRadius,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowStrong,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/gd.png', width: ScreenUtilHelper.scaleWidth(30), height: ScreenUtilHelper.scaleHeight(30)),
                        SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Uploaded File.pdf'),
                              SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                              LinearProgressIndicator(value: 0.7),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: ScreenUtilHelper.scaleWidth(20)),
                          onPressed: () {
                            setState(() {
                              fileSelected = false;
                              selectedAppName = '';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            fileSelected = false;
                            selectedAppName = '';
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryMedium,
                        ),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showSubmissionDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryMedium,
                          foregroundColor: AppColors.white,
                        ),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showOpenWithBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateBtm) {
            return Container(
              padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Open with', style: AppStyles.bold),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            fileSelected = true;
                            selectedAppName = 'Drive';
                          });
                          GoRouter.of(context).pop();
                        },
                        child: Column(
                          children: [
                            Image.asset('assets/images/gd.png', width: ScreenUtilHelper.scaleWidth(30), height: ScreenUtilHelper.scaleHeight(30)),
                            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                            Text('Drive'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            fileSelected = true;
                            selectedAppName = 'PDF Viewer';
                          });
                          GoRouter.of(context).pop();
                        },
                        child: Column(
                          children: [
                            Image.asset('assets/images/pdf.png', width: ScreenUtilHelper.scaleWidth(30), height: ScreenUtilHelper.scaleHeight(30)),
                            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
                            Text('PDF Viewer'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
                  Row(
                    children: [
                      Checkbox(
                        value: dontAskAgain,
                        onChanged: (bool? value) {
                          setStateBtm(() {
                            dontAskAgain = value!;
                          });
                        },
                      ),
                      Text('Don\'t ask again'),
                    ],
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSubmissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: ScreenUtilHelper.scaleWidth(60), color: AppColors.success),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
              Text(
                'Assignment Submitted!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMedium,
                  foregroundColor: AppColors.white,
                ),
                child: Text('Done'),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: AppDecorations.largeRadius,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.scaleHeight(30),
            horizontal: ScreenUtilHelper.scaleWidth(24),
          ),
        );
      },
    );
  }
}
