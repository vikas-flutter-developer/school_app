import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../book_list_screen.dart';
import '../bloc/add_book_bloc.dart';
import 'add_book_step1.dart';
import 'add_book_step2.dart';
import 'add_book_step3.dart';

class AddBookFlow extends StatelessWidget {
  const AddBookFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBookBloc, AddBookState>(
      builder: (context, state) {
        if (state is AddBookStep1) return AddBookStep1Widget();
        if (state is AddBookStep2) return AddBookStep2Widget();
        if (state is AddBookStep3) return AddBookStep3Widget();
        if (state is AddBookCompleted) return BookListScreen();
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
