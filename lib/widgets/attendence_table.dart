import 'package:flutter/material.dart';

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2), // Student Name
        1: FlexColumnWidth(1), // Reg no
        2: FlexColumnWidth(2), // Contact No
        3: FlexColumnWidth(1), // No of Days present
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: const [
        TableRow(
          decoration: BoxDecoration(color: Color(0xFFF2F2F7)), // Light grey background
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Student Name', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Reg no', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Contact No', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('No of Days\npresent', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Naveen')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('002')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('40', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('payal')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('001')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('42', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('pooja')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('003')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('32', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Vaishnavi')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('004')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('54', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Bikram')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('005')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('45', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Rutuja')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('006')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('34', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Dhanalakshmi')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('007')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('34', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.white),
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Diwija')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('008')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('56', textAlign: TextAlign.center)),
          ],
        ),
        TableRow(
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: Text('Asha')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('009')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('0000000000')),
            Padding(padding: EdgeInsets.all(8.0), child: Text('30', textAlign: TextAlign.center)),
          ],
        ),
      ],
    );
  }
}