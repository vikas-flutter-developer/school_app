import 'package:edudibon_flutter_bloc/teacher_module/service_screen/features/common_widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Assuming these are your custom helper classes
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  // Use a nullable enum to manage the state of the radio buttons
  String? _selectedOption = 'Query'; // Initial selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.white,size: 24,),
          onPressed: () => GoRouter.of(context).pop(),
          color: AppColors.primaryMedium,
        ),
        title: Text(
          'Create Ticket',
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(18),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryMedium,
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.silver,width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ticket ID section
              Padding(
                padding: EdgeInsets.all(ScreenUtilHelper.width(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request ID',
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(14),
                            color: AppColors.stone, // Assuming a light grey color
                          ),
                        ),
                        Text(
                          '2025 2536 78',
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.scaleText(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '04/23/2025',
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.scaleText(14),
                        color: AppColors.silver,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.silver), // Divider line below the header
              // Radio Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 'Query' radio button
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Query',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                      Text('Query'),
                    ],
                  ),
                  // 'Excalation' radio button
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Excalation',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                      Text('Excalation'),
                    ],
                  ),
                ],
              ),
          
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
                child: Text(
                  'Comment',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleWidth(8),
                      ),
                    ),
                    hintText: 'I am facing some issues regarding xyz. I request you to please look into it and update me accordingly.',
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
              Container(
                width: double.infinity,
                height: ScreenUtilHelper.scaleHeight(50),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(20)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryMedium,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleWidth(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showConfirmationDialog(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(16),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
            ],
          ),
        ),
      ),
    );
  }
}

