import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/screen_util_helper.dart';
import '../../../../../hrsm/widgets/Custom_logo_appbar.dart';
import '../bloc/add_book_bloc.dart';
import '../widgets/step_indicator.dart';

class AddBookStep1Widget extends StatefulWidget {
  const AddBookStep1Widget({super.key});

  @override
  State<AddBookStep1Widget> createState() => _AddBookStep1WidgetState();
}

class _AddBookStep1WidgetState extends State<AddBookStep1Widget> {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController editionController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController issnPrintController = TextEditingController();
  final TextEditingController issnElectronicController = TextEditingController();
  final TextEditingController publicationController = TextEditingController();
  final TextEditingController placeOfPublicationController = TextEditingController();
  final TextEditingController yearOfPublicationController = TextEditingController();
  final TextEditingController printingDateController = TextEditingController();

  String? selectedDeweyClass;

  final List<String> deweyOptions = [
    '000 – General works',
    '100 – Philosophy',
    '200 – Religion',
    '300 – Social sciences',
    '400 – Language',
    '500 – Science',
    '600 – Technology',
    '700 – Arts',
    '800 – Literature',
    '900 – History & geography',
  ];

  InputDecoration _inputDecoration(String label, {bool required = false}) {
    return InputDecoration(
      labelText: required ? '$label *' : label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.border,
          width: 0.5,
        )
      ),
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

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return Scaffold(
      appBar: CustomLogoAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepIndicator(currentStep: 1),
              const SizedBox(height: 24),
              Center(child: Text("Basic Book Information", style: AppStyles.body20Plain)),
              const SizedBox(height: 16),

              // Book Name, Author, Subtitle
              SizedBox(
                  height: 40,
                  width: 400,
                  child: TextField(
                      controller: bookNameController,
                      decoration: _inputDecoration("Book name", required: true))),
              const SizedBox(height: 15),
              SizedBox(
                  height: 40,
                  width: 400,
                  child: TextField(
                      controller: authorController,
                      decoration: _inputDecoration("Author", required: true))),
              const SizedBox(height: 15),
              SizedBox(
                height: 40,
                width: 400,
                child: TextField(
                    controller: subTitleController,
                    decoration: _inputDecoration("Sub Title")),
              ),
              const SizedBox(height: 25),

              // Volume & Edition
              _twoFields(
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: volumeController,
                        decoration: _inputDecoration("Volume"))),
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(controller: editionController,
                        decoration: _inputDecoration("Edition"))),
              ),
              const SizedBox(height: 15),

              // ISBN & ISSN Print
              _twoFields(
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: isbnController,
                        decoration: _inputDecoration("ISBN no"))),
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: issnPrintController,
                        decoration: _inputDecoration("ISSN print"))),
              ),
              const SizedBox(height: 15),

              // ISSN Electronic
              SizedBox(
                  height: 40,
                  width: 400,
                  child: TextField(
                      controller: issnElectronicController,
                      decoration: _inputDecoration("ISSN Electronic"))),
              const SizedBox(height: 25),

              // Publication & Place
              _twoFields(
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: publicationController,
                        decoration: _inputDecoration("Publication"))),
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: placeOfPublicationController,
                        decoration: _inputDecoration("Place of Publication"))),
              ),
              const SizedBox(height: 15),

              // Year & Printing Date
              _twoFields(
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: yearOfPublicationController,
                        decoration: _inputDecoration("Year of Publication"))),
                SizedBox(
                    height: 40,
                    width: 195,
                    child: TextField(
                        controller: printingDateController,
                        decoration: _inputDecoration("Printing Date"))),
              ),
              const SizedBox(height: 20),

              // Dropdown
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.border,
                          width: 0.5,
                        )
                      ),
                      child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                      value: selectedDeweyClass,
                      hint: Center(child: const Text("Deway decimal system class name",)),
                      isExpanded: true,
                      items: deweyOptions.map((option) {
                        return DropdownMenuItem(value: option, child: Text(option));
                      }).toList(),
                      onChanged: (value) => setState(() => selectedDeweyClass = value),
                                        ),
                                    ),
                    ),
              const SizedBox(height: 24),

              Center(
                child: SizedBox(
                  width: 150,
                  height: 46,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryMedium),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      final bookName = bookNameController.text.trim();
                      final author = authorController.text.trim();
                      final subTitle = subTitleController.text.trim();

                      if (bookName.isNotEmpty && author.isNotEmpty) {
                        context.read<AddBookBloc>().add(
                          AddStep1Submitted(
                            bookName: bookName,
                            author: author,
                            subTitle: subTitle.isNotEmpty ? subTitle : null,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Book name and author are required')),
                        );
                      }
                    },
                    child: const Text("Next", style: TextStyle(color: AppColors.primaryMedium)),
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
