import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_util_helper.dart';
import '../../../../../hrsm/widgets/Custom_logo_appbar.dart';
import '../../../book_list_screen.dart';
import '../bloc/add_book_bloc.dart';
import '../widgets/step_indicator.dart';

class AddBookStep3Widget extends StatefulWidget {
  const AddBookStep3Widget({super.key});

  @override
  State<AddBookStep3Widget> createState() => _AddBookStep3WidgetState();
}

class _AddBookStep3WidgetState extends State<AddBookStep3Widget> {
  final TextEditingController accessionNoController = TextEditingController();
  final TextEditingController callNoController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController orderNoController = TextEditingController();
  final TextEditingController orderDateController = TextEditingController();
  final TextEditingController sanctionNoController = TextEditingController();
  final TextEditingController sanctionDateController = TextEditingController();
  final TextEditingController bookLocationController = TextEditingController();
  final TextEditingController billDateController = TextEditingController();
  final TextEditingController billNoController = TextEditingController();

  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController subjectIdController = TextEditingController();
  final TextEditingController bookKeywordsController = TextEditingController();
  final TextEditingController bookLanguageController = TextEditingController();

  InputDecoration _inputDecoration(String label, {bool required = false}) {
    return InputDecoration(
      labelText: required ? '$label *' : label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _twoFields(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  void _showBookAddedOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        left: MediaQuery.of(context).size.width * 0.2,
        right: MediaQuery.of(context).size.width * 0.2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.check_circle, color: Colors.deepPurple, size: 20),
                SizedBox(width: 8),
                Text(
                  'Book Added',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return BlocListener<AddBookBloc, AddBookState>(
      listener: (context, state) {
        if (state is AddBookCompleted) {
          _showBookAddedOverlay(context);
        }
      },
      child: Scaffold(
        appBar: CustomLogoAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StepIndicator(currentStep: 3),
                const SizedBox(height: 24),
                Center(child: Text("Copies", style: AppStyles.headingLPlain)),
                const SizedBox(height: 16),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: accessionNoController,
                      decoration: _inputDecoration("Accession no.", required: true),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: callNoController,
                      decoration: _inputDecoration("Call no."),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: barcodeController,
                      decoration: _inputDecoration("Barcode"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: orderNoController,
                      decoration: _inputDecoration("Order no."),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: orderDateController,
                      readOnly: true,
                      onTap: () => _pickDate(orderDateController),
                      decoration: _inputDecoration("Order date").copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: sanctionNoController,
                      decoration: _inputDecoration("Sanction no."),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: sanctionDateController,
                      readOnly: true,
                      onTap: () => _pickDate(sanctionDateController),
                      decoration: _inputDecoration("Sanction date").copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: bookLocationController,
                      decoration: _inputDecoration("Book location"),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: billDateController,
                      readOnly: true,
                      onTap: () => _pickDate(billDateController),
                      decoration: _inputDecoration("Bill date").copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: billNoController,
                      decoration: _inputDecoration("Bill no."),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Center(child: Text("Subject & Categories", style: AppStyles.headingLPlain)),
                const SizedBox(height: 25),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: categoryIdController,
                      decoration: _inputDecoration("Category ID", required: true),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: subjectIdController,
                      decoration: _inputDecoration("Subject ID"),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                _twoFields(
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: bookKeywordsController,
                      decoration: _inputDecoration("Book Keywords"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: bookLanguageController,
                      decoration: _inputDecoration("Book Language"),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        _showBookAddedOverlay(context);
                        context.pushReplacement(AppRoutes.libraryTotalStock);
                        // context.read<AddBookBloc>().add(AddStep3Submitted(
                        //   accessionNo: accessionNoController.text.trim(),
                        //   categoryId: categoryIdController.text.trim(),
                        //   // Add other fields as needed
                        // ));
                      },
                      child: const Text(
                        "Add Book",
                        style: TextStyle(fontSize: 16, color: Colors.white),
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
      ),
    );
  }
}
