
import 'dart:convert';

StudentModels studentModelsFromJson(String str) =>
    StudentModels.fromJson(json.decode(str));

String studentModelsToJson(StudentModels data) => json.encode(data.toJson());

class StudentModels {
  StudentModels({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  String status;

  // DUMMY DATA FACTORY
  factory StudentModels.createDummy() {
    return StudentModels(
      data: Data(
        motherId: [],
        gender: "Male",
        guardianId: [],
        classId: [],
        studentId: [],
        guardianMobile: "9090909090",
        dob: DateTime(1998, 11, 5),
        admittedDate: "2 July, 2024",
        name: "NAVEEN NAVEEN",
        admissionNumber: "C5113171140490",
        bloodGroup: "O +ve",
        motherMobile: "N/A",
        fatherId: [],
        id: 1,
        dataClass: Class(
          code: "10C",
          sectionId: [],
          departmentId: [],
          subjectIds: [],
          teacherId: [],
          subjects: [
            Subject(
              // Placeholder image for profile picture
              staffImage: "https://i.pravatar.cc/150?img=12",
              subjectId: [],
              sequence: 1,
              code: "SUB101",
              staffId: [],
              id: 101,
            )
          ],
          name: "10 C",
          id: 10,
          academicYearId: ["AY2024", "2024-2025"], // Dummy academic year
        ),
        rollNumber: "0056",
        fatherMobile: "N/A",
        emergencyContact: "9090909090",
        // ADDED FIELDS TO MATCH UI
        fatherName: "Naveen B",
        email: "nabeen1234@gmail.com",
        mobileNumber: "9090909090",
        address: "C/o 342, D.P Nagar, Bengaluru, KA-560000",
        status: "New admission",
        scholarNumber: "134dcrf3098",
        attendance: 81,
        timeOff: 4,
        grade: 10,
      ),
      message: "Dummy data loaded successfully.",
      status: "Success",
    );
  }


  factory StudentModels.fromJson(Map<dynamic, dynamic> json) => StudentModels(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<dynamic, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class Data {
  Data({
    required this.motherId,
    required this.gender,
    required this.guardianId,
    required this.classId,
    required this.studentId,
    required this.guardianMobile,
    required this.dob,
    required this.admittedDate,
    required this.name,
    required this.admissionNumber,
    required this.bloodGroup,
    required this.motherMobile,
    required this.fatherId,
    required this.id,
    required this.dataClass,
    required this.rollNumber,
    required this.fatherMobile,
    required this.emergencyContact,
    // ADDED FIELDS
    required this.fatherName,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.status,
    required this.scholarNumber,
    required this.attendance,
    required this.timeOff,
    required this.grade,
  });

  List<dynamic> motherId;
  String gender;
  List<dynamic> guardianId;
  List<dynamic> classId;
  List<dynamic> studentId;
  String guardianMobile;
  DateTime dob;
  String admittedDate;
  String name;
  String admissionNumber;
  String bloodGroup;
  String motherMobile;
  List<dynamic> fatherId;
  int id;
  Class dataClass;
  String rollNumber;
  String fatherMobile;
  String emergencyContact;
  // ADDED FIELDS
  String fatherName;
  String email;
  String mobileNumber;
  String address;
  String status;
  String scholarNumber;
  int attendance;
  int timeOff;
  int grade;


  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    motherId: List<dynamic>.from(json["mother_id"].map((x) => x)),
    gender: json["gender"],
    guardianId: List<dynamic>.from(json["guardian_id"].map((x) => x)),
    classId: List<dynamic>.from(json["class_id"].map((x) => x)),
    studentId: List<dynamic>.from(json["student_id"].map((x) => x)),
    guardianMobile: json["guardian_mobile"],
    dob: DateTime.parse(json["dob"]),
    admittedDate: json["admitted_date"],
    name: json["name"],
    admissionNumber: json["admission_number"],
    bloodGroup: json["blood_group"],
    motherMobile: json["mother_mobile"],
    fatherId: List<dynamic>.from(json["father_id"].map((x) => x)),
    id: json["id"],
    dataClass: Class.fromJson(json["class"]),
    rollNumber: json["roll_number"],
    fatherMobile: json["father_mobile"],
    emergencyContact: json["emergency_contact"],
    // ADDED FIELDS with fallback values
    fatherName: json["father_name"] ?? 'N/A',
    email: json["email"] ?? 'N/A',
    mobileNumber: json["mobile_number"] ?? 'N/A',
    address: json["address"] ?? 'N/A',
    status: json["status"] ?? 'N/A',
    scholarNumber: json["scholar_number"] ?? 'N/A',
    attendance: json["attendance"] ?? 0,
    timeOff: json["time_off"] ?? 0,
    grade: json["grade"] ?? 0,
  );

  Map<dynamic, dynamic> toJson() => {
    "mother_id": List<dynamic>.from(motherId.map((x) => x)),
    "gender": gender,
    "guardian_id": List<dynamic>.from(guardianId.map((x) => x)),
    "class_id": List<dynamic>.from(classId.map((x) => x)),
    "student_id": List<dynamic>.from(studentId.map((x) => x)),
    "guardian_mobile": guardianMobile,
    "dob":
    "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "admitted_date": admittedDate,
    "name": name,
    "admission_number": admissionNumber,
    "blood_group": bloodGroup,
    "mother_mobile": motherMobile,
    "father_id": List<dynamic>.from(fatherId.map((x) => x)),
    "id": id,
    "class": dataClass.toJson(),
    "roll_number": rollNumber,
    "father_mobile": fatherMobile,
    "emergency_contact": emergencyContact,
    // ADDED FIELDS
    "father_name": fatherName,
    "email": email,
    "mobile_number": mobileNumber,
    "address": address,
    "status": status,
    "scholar_number": scholarNumber,
    "attendance": attendance,
    "time_off": timeOff,
    "grade": grade,
  };
}

class Class {
  Class({
    required this.code,
    required this.sectionId,
    required this.departmentId,
    required this.subjectIds,
    required this.teacherId,
    required this.subjects,
    required this.name,
    required this.id,
    required this.academicYearId,
  });

  String code;
  List<dynamic> sectionId;
  List<dynamic> departmentId;
  List<int> subjectIds;
  List<dynamic> teacherId;
  List<Subject> subjects;
  String name;
  int id;
  List<dynamic> academicYearId;

  factory Class.fromJson(Map<dynamic, dynamic> json) => Class(
    code: json["code"],
    sectionId: List<dynamic>.from(json["section_id"].map((x) => x)),
    departmentId: List<dynamic>.from(json["department_id"].map((x) => x)),
    subjectIds: List<int>.from(json["subject_ids"].map((x) => x)),
    teacherId: List<dynamic>.from(json["teacher_id"].map((x) => x)),
    subjects: List<Subject>.from(
      json["subjects"].map((x) => Subject.fromJson(x)),
    ),
    name: json["name"],
    id: json["id"],
    academicYearId: List<dynamic>.from(json["academic_year_id"].map((x) => x)),
  );

  Map<dynamic, dynamic> toJson() => {
    "code": code,
    "section_id": List<dynamic>.from(sectionId.map((x) => x)),
    "department_id": List<dynamic>.from(departmentId.map((x) => x)),
    "subject_ids": List<dynamic>.from(subjectIds.map((x) => x)),
    "teacher_id": List<dynamic>.from(teacherId.map((x) => x)),
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    "name": name,
    "id": id,
    "academic_year_id": List<dynamic>.from(academicYearId.map((x) => x)),
  };
}

class Subject {
  Subject({
    required this.staffImage,
    required this.subjectId,
    required this.sequence,
    required this.code,
    required this.staffId,
    required this.id,
  });

  String staffImage;
  List<dynamic> subjectId;
  int sequence;
  String code;
  List<dynamic> staffId;
  int id;

  factory Subject.fromJson(Map<dynamic, dynamic> json) => Subject(
    staffImage: json["staff_image"],
    subjectId: List<dynamic>.from(json["subject_id"].map((x) => x)),
    sequence: json["sequence"],
    code: json["code"],
    staffId: List<dynamic>.from(json["staff_id"].map((x) => x)),
    id: json["id"],
  );

  Map<dynamic, dynamic> toJson() => {
    "staff_image": staffImage,
    "subject_id": List<dynamic>.from(subjectId.map((x) => x)),
    "sequence": sequence,
    "code": code,
    "staff_id": List<dynamic>.from(staffId.map((x) => x)),
    "id": id,
  };
}