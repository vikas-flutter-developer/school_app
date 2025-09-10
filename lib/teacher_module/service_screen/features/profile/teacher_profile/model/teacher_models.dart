/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
library;

import 'dart:convert';

TeacherModels teacherModelsFromJson(String str) =>
    TeacherModels.fromJson(json.decode(str));

String teacherModelsToJson(TeacherModels data) => json.encode(data.toJson());

class TeacherModels {
  TeacherModels({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  String status;

  factory TeacherModels.fromJson(Map<dynamic, dynamic> json) => TeacherModels(
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
