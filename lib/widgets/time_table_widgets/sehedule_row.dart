import 'package:flutter/material.dart';

class ScheduleRow extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String subject;
  final String teacher;
  final String date;

  const ScheduleRow({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.teacher,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(startTime, style: const TextStyle(fontSize: 16)),
            Text(endTime, style: const TextStyle(fontSize: 12)),
          ],
        ),
        Container(
          width: 268,
          height: 100,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.indigo,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                    ),
                    Text(
                      teacher,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color.fromRGBO(183, 180, 226, 1),
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "HomeWork/Assignment",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
