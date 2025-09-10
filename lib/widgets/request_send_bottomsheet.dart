import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showRequestSentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 459,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                'Your request has been sent',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Open Sans',
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/Frame.png')),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 338,
                height: 49,
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop(); // Close the bottom sheet
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: const BorderSide(color: Colors.indigo, width: 1.0),
                    ),
                  ),
                  child: const Text("Go To Home"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
