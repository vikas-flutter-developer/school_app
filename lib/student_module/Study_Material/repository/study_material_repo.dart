import '../model/study_material_model.dart';

class StudyMaterialRepository {
  Future<List<StudyMaterial>> fetchStudyMaterials() async {
    await Future.delayed(Duration(seconds: 2)); // Simulated API delay
    return [
      StudyMaterial(title: "Subject Title", details: "Algebra, Geometry"),
      StudyMaterial(title: "Subject Title", details: "Mechanics, Optics"),
      StudyMaterial(title: "Subject Title", details: "Organic, Inorganic"),
      StudyMaterial(title: "Subject Title", details: "Botany, Zoology"),
    ];
  }
}
