import '../../../data/models/major_model.dart';
import '../../../data/models/question_model.dart';

class ScoringEngine {
  /// Options weights: Yes=3, Sometimes=1, No=0
  static const Map<String, int> optionWeights = {
    "opt_yes": 3,
    "opt_sometimes": 1,
    "opt_no": 0,
  };

  static List<MajorModel> calculateCompatibility(
      List<MajorModel> allMajors, 
      List<QuestionModel> questions, 
      Map<String, String> answers) {
    
    // 1. Calculate tag strengths from answers
    Map<String, int> tagStrengths = {};
    for (var question in questions) {
      String? answerKey = answers[question.id];
      if (answerKey != null) {
        int weight = optionWeights[answerKey] ?? 0;
        for (var tag in question.relatedTags) {
          tagStrengths[tag] = (tagStrengths[tag] ?? 0) + weight;
        }
      }
    }

    // 2. Score each major based on tag matches
    List<MajorModel> scoredMajors = allMajors.map((major) {
      double score = 0;
      for (var tag in major.trackTags) {
        if (tagStrengths.containsKey(tag)) {
          // Normalize: cap at some relative value for dummy logic
          score += tagStrengths[tag]!;
        }
      }

      // Normalize score to 0-100%
      // In real scenario, this would be a more complex vector similarity
      double normalizedScore = (score / 30).clamp(0.0, 1.0) * 100;
      
      major.compatibilityScore = normalizedScore;
      return major;
    }).toList();

    // 3. Sort by score descending
    scoredMajors.sort((a, b) => (b.compatibilityScore ?? 0).compareTo(a.compatibilityScore ?? 0));
    
    return scoredMajors;
  }
}
