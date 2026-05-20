import '../models/major_model.dart';

class MockMatchingService {
  /// Calculates compatibility scores for all majors based on questionnaire answers.
  /// answers: Map of questionId -> optionKey (e.g., {"s1": "opt_yes", "t1": "opt_no"})
  /// tagsMap: Map of questionId -> List of related tags
  static Future<List<MajorModel>> getScoredSuggestedMajors({
    required List<MajorModel> allMajors,
    required Map<String, String> answers,
    required Map<String, List<String>> questionTags,
  }) async {
    // Artificial delay to simulate heavy calculation/ML processing
    await Future.delayed(const Duration(seconds: 2));

    // 1. Calculate weighted tag scores from answers
    final Map<String, double> userTraitScores = {};
    
    answers.forEach((qId, option) {
      final tags = questionTags[qId] ?? [];
      double weight = 0.0;
      
      if (option == "opt_yes") weight = 1.0;
      if (option == "opt_sometimes") weight = 0.4;
      if (option == "opt_no") weight = -0.5;

      for (var tag in tags) {
        userTraitScores[tag] = (userTraitScores[tag] ?? 0.0) + weight;
      }
    });

    // 2. Score each major based on its trackTags and userTraitScores
    final List<MajorModel> scoredMajors = allMajors.map((major) {
      double score = 0.0;
      int matchCount = 0;

      // Primary Match: Major's explicit trait tags
      for (var trait in major.trackTags) {
        if (userTraitScores.containsKey(trait)) {
          score += userTraitScores[trait]!;
          matchCount++;
        }
      }

      // Bonus Match: Required traits
      for (var trait in major.requiredTraits) {
        if (userTraitScores.containsKey(trait) && userTraitScores[trait]! > 0) {
          score += userTraitScores[trait]! * 0.5;
        }
      }

      // Normalize score to 0-100 range
      // This is a simplified mock formula
      double finalScore = (score * 10) + 50; // Base 50%
      if (finalScore > 98) finalScore = 98; // Leave room for "perfect"
      if (finalScore < 30) finalScore = 32; // Guaranteed floor for motivation

      return MajorModel(
        id: major.id,
        name: major.name,
        description: major.description,
        university: major.university,
        location: major.location,
        universityType: major.universityType,
        programType: major.programType,
        predictedChance: major.predictedChance,
        confidenceScore: major.confidenceScore,
        historicalAcceptanceData: major.historicalAcceptanceData,
        trendDirection: major.trendDirection,
        duration: major.duration,
        mainSubjects: major.mainSubjects,
        studyIntensity: major.studyIntensity,
        intensityReason: major.intensityReason,
        difficultyLevel: major.difficultyLevel,
        difficultyReason: major.difficultyReason,
        coreSkills: major.coreSkills,
        certifications: major.certifications,
        suitedPersonality: major.suitedPersonality,
        commonChallenges: major.commonChallenges,
        careerPaths: major.careerPaths,
        workEnvironments: major.workEnvironments,
        jobAvailability: major.jobAvailability,
        marketSaturation: major.marketSaturation,
        incomeRange: major.incomeRange,
        incomeGrowth: major.incomeGrowth,
        incomeStability: major.incomeStability,
        mastersSpecializations: major.mastersSpecializations,
        phdPaths: major.phdPaths,
        fieldSwitchingFlexibility: major.fieldSwitchingFlexibility,
        internationalOpportunities: major.internationalOpportunities,
        pros: major.pros,
        cons: major.cons,
        notSuitableFor: major.notSuitableFor,
        timeToIncome: major.timeToIncome,
        demandVsReturn: major.demandVsReturn,
        flexibilityScore: major.flexibilityScore,
        trackTags: major.trackTags,
        requiredTraits: major.requiredTraits,
        predictedTanafos: major.predictedTanafos,
        predictedMowazi: major.predictedMowazi,
        aiDisclaimer: major.aiDisclaimer,
        graduateContacts: major.graduateContacts,
        compatibilityScore: finalScore,
      );
    }).toList();

    // 3. Sort by score descending
    scoredMajors.sort((a, b) => (b.compatibilityScore ?? 0).compareTo(a.compatibilityScore ?? 0));

    return scoredMajors;
  }
}
