import 'bilingual_text.dart';

class SubjectModel {
  final BilingualText name;
  final BilingualText description;

  const SubjectModel({
    required this.name,
    required this.description,
  });
}

class MajorModel {
  final String id;
  final BilingualText name;
  final BilingualText description;
  final BilingualText university;
  final BilingualText location;
  final String universityType;
  final String programType;
  
  final String predictedChance;
  final double confidenceScore; 
  final List<Map<String, dynamic>> historicalAcceptanceData;
  final String trendDirection;

  final int duration;
  final List<SubjectModel> mainSubjects;
  final String studyIntensity;
  final BilingualText intensityReason;
  final String difficultyLevel;
  final BilingualText difficultyReason;

  final List<SubjectModel> coreSkills;
  final List<BilingualText> certifications;
  final BilingualText suitedPersonality;
  final List<BilingualText> commonChallenges;

  final List<SubjectModel> careerPaths;
  final List<BilingualText> workEnvironments;
  final String jobAvailability;
  final String marketSaturation;

  final String incomeRange;
  final String incomeGrowth;
  final String incomeStability;

  final List<BilingualText> mastersSpecializations;
  final List<BilingualText> phdPaths;
  final double fieldSwitchingFlexibility;
  final BilingualText internationalOpportunities;

  final List<BilingualText> pros;
  final List<BilingualText> cons;
  final BilingualText notSuitableFor;

  final String timeToIncome;
  final double demandVsReturn;
  final double flexibilityScore;
  
  final List<String> trackTags; 
  final List<String> requiredTraits; 
  double? compatibilityScore; 

  // Prediction Fields
  final double predictedTanafos;
  final double? predictedMowazi;
  final BilingualText aiDisclaimer;

  final List<GraduateContact> graduateContacts;

  MajorModel({
    required this.id,
    required this.name,
    required this.description,
    required this.university,
    required this.location,
    required this.universityType,
    required this.programType,
    required this.predictedChance,
    required this.confidenceScore,
    required this.historicalAcceptanceData,
    required this.trendDirection,
    required this.duration,
    required this.mainSubjects,
    required this.studyIntensity,
    required this.intensityReason,
    required this.difficultyLevel,
    required this.difficultyReason,
    required this.coreSkills,
    required this.certifications,
    required this.suitedPersonality,
    required this.commonChallenges,
    required this.careerPaths,
    required this.workEnvironments,
    required this.jobAvailability,
    required this.marketSaturation,
    required this.incomeRange,
    required this.incomeGrowth,
    required this.incomeStability,
    required this.mastersSpecializations,
    required this.phdPaths,
    required this.fieldSwitchingFlexibility,
    required this.internationalOpportunities,
    required this.pros,
    required this.cons,
    required this.notSuitableFor,
    required this.timeToIncome,
    required this.demandVsReturn,
    required this.flexibilityScore,
    required this.trackTags,
    required this.requiredTraits,
    this.compatibilityScore,
    required this.predictedTanafos,
    this.predictedMowazi,
    required this.aiDisclaimer,
    required this.graduateContacts,
  });
}


class GraduateContact {
  final BilingualText name;
  final int gradYear;
  final String contactInfo;

  GraduateContact({
    required this.name,
    required this.gradYear,
    required this.contactInfo,
  });
}
