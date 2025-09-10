// models/student.dart (create this file if it doesn't exist)
class Student {
  final String srNo;
  final String admissionNo;
  final String name;
  final String contactNo;
  final String stat;

  const Student({
    required this.srNo,
    required this.admissionNo,
    required this.name,
    required this.contactNo,
    required this.stat
  });
}

// Dummy data for demonstration
const List<Student> dummyStudents = [
  Student(srNo: '1', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '2', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '3', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '4', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '5', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '6', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '7', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '8', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  Student(srNo: '9', admissionNo: '9456789', name: 'Lorem Ipsum', contactNo: '983-114-9856', stat: ''),
  // Add more students if needed for scrolling testing
];