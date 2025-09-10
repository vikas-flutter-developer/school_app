import 'package:flutter/material.dart';

class OpenWithBottomSheet extends StatelessWidget {
  const OpenWithBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 430,
      height: 300,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "open with",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Text(
                  "cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 70,
                      height: 71,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/gd.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 70,
                      height: 71,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/pdf.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                      side: const BorderSide(
                        color: Color.fromRGBO(152, 152, 152, 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  "don't ask again",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(152, 152, 152, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
