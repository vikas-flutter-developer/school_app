import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_util_helper.dart';
import '../../../../../hrsm/widgets/Custom_logo_appbar.dart';
import '../bloc/add_book_bloc.dart';
import '../widgets/step_indicator.dart';

class AddBookStep2Widget extends StatefulWidget {
  const AddBookStep2Widget({super.key});

  @override
  State<AddBookStep2Widget> createState() => _AddBookStep2WidgetState();
}

class _AddBookStep2WidgetState extends State<AddBookStep2Widget> {
  final TextEditingController noOfCopiesController = TextEditingController();
  final TextEditingController noOfPagesController = TextEditingController();
  final TextEditingController purchasingDateController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController bookRemarksController = TextEditingController();
  final TextEditingController withdrawalDetailsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController supplierIdController = TextEditingController();
  final TextEditingController bookContentController = TextEditingController();

  bool issueable = false;

  InputDecoration _inputDecoration(String label, {bool required = false}) {
    return InputDecoration(
      hintText: required ? '$label *' : label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.border,
          width: 0.5,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(16),
        vertical: ScreenUtilHelper.scaleHeight(12),
      ),
    );
  }

  Widget _twoFields(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        SizedBox(width: ScreenUtilHelper.scaleWidth(12)),
        Expanded(child: right),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: CustomLogoAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepIndicator(currentStep: 2),
              SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
              Center(
                child: Text(
                  "Copy & Acquisition Details",
                  style: AppStyles.headingLPlain,
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(16)),

              _twoFields(
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: noOfCopiesController,
                    decoration: _inputDecoration("No. of Copies", required: true),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: InputDecorator(
                    decoration: _inputDecoration("Issueable", required: true),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<bool>(
                        value: issueable,
                        isExpanded: true,
                        onChanged: (val) => setState(() => issueable = val!),
                        items: const [
                          DropdownMenuItem(value: true, child: Text("Yes")),
                          DropdownMenuItem(value: false, child: Text("No")),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

              _twoFields(
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: noOfPagesController,
                    decoration: _inputDecoration("No. of Pages"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: purchasingDateController,
                    readOnly: true,
                    decoration: _inputDecoration("Purchasing date").copyWith(
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        initialDate: DateTime.now(),
                      );
                      if (picked != null) {
                        purchasingDateController.text = "${picked.toLocal()}".split(' ')[0];
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

              TextField(
                controller: sourceController,
                decoration: _inputDecoration("Source"),
                maxLines: 4,
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

              _twoFields(
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: bookRemarksController,
                    decoration: _inputDecoration("Book Remarks"),
                  ),
                ),
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: withdrawalDetailsController,
                    decoration: _inputDecoration("Withdrawal Details"),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

              _twoFields(
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: priceController,
                    decoration: _inputDecoration("Price"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: ScreenUtilHelper.scaleHeight(40),
                  child: TextField(
                    controller: supplierIdController,
                    decoration: _inputDecoration("Supplier ID"),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(15)),

              TextField(
                controller: bookContentController,
                decoration: _inputDecoration("Book Content"),
                maxLines: 4,
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(24)),

              Center(
                child: SizedBox(
                  width: ScreenUtilHelper.scaleWidth(150),
                  height: ScreenUtilHelper.scaleHeight(46),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryMedium),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final noOfCopies = int.tryParse(noOfCopiesController.text.trim()) ?? 0;
                      context.read<AddBookBloc>().add(AddStep2Submitted(
                        noOfCopies: noOfCopies,
                        issueable: issueable,
                      ));
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: AppColors.primaryMedium),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Account'),
        ],
      ),
    );
  }
}
