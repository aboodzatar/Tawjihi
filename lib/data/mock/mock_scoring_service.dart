import '../../../data/models/major_model.dart';
import '../../../data/models/question_model.dart';
import '../../features/questionnaire/controller/scoring_engine.dart';
import 'mock_majors_service.dart';

class MockScoringService {
  static Future<List<MajorModel>> getScoredResults(
      List<QuestionModel> questions, 
      Map<String, String> answers) async {
    
    // Simulate complex calculation
    await Future.delayed(const Duration(milliseconds: 1200));
    
    final allMajors = await MockMajorsService.getAllMajors();
    return ScoringEngine.calculateCompatibility(allMajors, questions, answers);
  }
}
