import '../models/question_model.dart';

class MockQuestionnaireService {
  static final List<QuestionModel> _questions = [
    // Step 1: Global / Personality (9)
    QuestionModel(id: "s1", textKey: "q_logic", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["logic", "math", "analysis"]),
    QuestionModel(id: "s2", textKey: "q_creativity", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["design", "art", "creative"]),
    QuestionModel(id: "s3", textKey: "q_helping", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["health", "social", "patient_care"]),
    QuestionModel(id: "s4", textKey: "q_leadership", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["business", "management", "leadership"]),
    QuestionModel(id: "s5", textKey: "q_writing", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["writing", "humanities", "communication"]),
    QuestionModel(id: "s6", textKey: "q_tech_interest", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["coding", "tech", "hardware"]),
    QuestionModel(id: "s7", textKey: "q_problem_solving", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["engineering", "logic", "mechanics"]),
    QuestionModel(id: "s8", textKey: "q_detail_oriented", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["health", "math", "detail", "accounting"]),
    QuestionModel(id: "s9", textKey: "q_working_with_people", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "global", relatedTags: ["social", "business", "teaching"]),

    // Step 3: Track-Specific (6 per track)

    // Health Track (track_health)
    QuestionModel(id: "h1", textKey: "q_blood", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_health", relatedTags: ["health", "biology"]),
    QuestionModel(id: "h2", textKey: "q_biology", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_health", relatedTags: ["biology", "science"]),
    QuestionModel(id: "h3", textKey: "q_stress_handling", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_health", relatedTags: ["health", "resilience"]),
    QuestionModel(id: "h4", textKey: "q_medical_ethics", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_health", relatedTags: ["health", "ethics"]),
    QuestionModel(id: "h5", textKey: "q_body_function", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_health", relatedTags: ["health", "biology"]),
    QuestionModel(id: "h6", textKey: "q_lab_work", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_health", relatedTags: ["health", "science", "chemistry"]),

    // Engineering Track (track_eng)
    QuestionModel(id: "e1", textKey: "q_building", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_eng", relatedTags: ["engineering", "design"]),
    QuestionModel(id: "e2", textKey: "q_math_passion", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_eng", relatedTags: ["math", "logic"]),
    QuestionModel(id: "e3", textKey: "q_tinkering", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_eng", relatedTags: ["engineering", "physics", "tinkering"]),
    QuestionModel(id: "e4", textKey: "q_physics", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_eng", relatedTags: ["physics", "math"]),
    QuestionModel(id: "e5", textKey: "q_spatial", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_eng", relatedTags: ["engineering", "spatial"]),
    QuestionModel(id: "e6", textKey: "q_innovation", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_eng", relatedTags: ["engineering", "design"]),

    // Tech Track (track_it)
    QuestionModel(id: "t1", textKey: "q_coding", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_it", relatedTags: ["tech", "coding"]),
    QuestionModel(id: "t2", textKey: "q_gaming_tech", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_it", relatedTags: ["tech", "design"]),
    QuestionModel(id: "t3", textKey: "q_automation", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_it", relatedTags: ["tech", "logic", "coding"]),
    QuestionModel(id: "t4", textKey: "q_networks", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_it", relatedTags: ["tech", "security"]),
    QuestionModel(id: "t5", textKey: "q_ai_future", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_it", relatedTags: ["tech", "math", "logic"]),
    QuestionModel(id: "t6", textKey: "q_hardware", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_it", relatedTags: ["tech", "tinkering"]),

    // Business Track (track_business)
    QuestionModel(id: "b1", textKey: "q_selling", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_business", relatedTags: ["business", "social"]),
    QuestionModel(id: "b2", textKey: "q_accounting", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_business", relatedTags: ["business", "math"]),
    QuestionModel(id: "b3", textKey: "q_entrepreneur", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_business", relatedTags: ["business", "leadership"]),
    QuestionModel(id: "b4", textKey: "q_marketing", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_business", relatedTags: ["business", "writing"]),
    QuestionModel(id: "b5", textKey: "q_negotiation", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_business", relatedTags: ["business", "management"]),
    QuestionModel(id: "b6", textKey: "q_econ", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_business", relatedTags: ["business", "math"]),

    // Humanities (track_humanities)
    QuestionModel(id: "hu1", textKey: "q_history", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_humanities", relatedTags: ["humanities", "writing"]),
    QuestionModel(id: "hu2", textKey: "q_psychology", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_humanities", relatedTags: ["humanities", "social"]),
    QuestionModel(id: "hu3", textKey: "q_teaching", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_humanities", relatedTags: ["humanities", "social", "teaching"]),
    QuestionModel(id: "hu4", textKey: "q_literature", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_humanities", relatedTags: ["humanities", "writing"]),
    QuestionModel(id: "hu5", textKey: "q_arts", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_humanities", relatedTags: ["humanities", "design"]),
    QuestionModel(id: "hu6", textKey: "q_philosophy", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_humanities", relatedTags: ["humanities", "logic"]),

    // Law (track_law)
    QuestionModel(id: "l1", textKey: "q_debating", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_law", relatedTags: ["law", "logic"]),
    QuestionModel(id: "l2", textKey: "q_justice", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_law", relatedTags: ["law", "ethics"]),
    QuestionModel(id: "l3", textKey: "q_reading_laws", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_law", relatedTags: ["law", "humanities"]),
    QuestionModel(id: "l4", textKey: "q_public_speaking", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_law", relatedTags: ["law", "social", "communication"]),
    QuestionModel(id: "l5", textKey: "q_investigation", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_law", relatedTags: ["law", "security"]),
    QuestionModel(id: "l6", textKey: "q_contracts", optionsKeys: ["opt_no", "opt_sometimes", "opt_yes"], track: "track_law", relatedTags: ["law", "writing"]),
  ];

  static Future<List<QuestionModel>> getGlobalQuestions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _questions.where((q) => q.track == "global").toList();
  }

  static Future<List<QuestionModel>> getTrackQuestions(String trackId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _questions.where((q) => q.track == trackId).toList();
  }

  static Map<String, List<String>> getQuestionTagsMap() {
    final Map<String, List<String>> map = {};
    for (var q in _questions) {
      map[q.id] = q.relatedTags;
    }
    return map;
  }

  // Legacy Support for QuestionnaireController
  static Future<List<QuestionModel>> getQuestionsForTrack(String? trackId) async {
    final global = await getGlobalQuestions();
    if (trackId == null) return global;
    
    // Map legacy track names to new keys if necessary
    String mappedTrack = trackId;
    if (trackId.toLowerCase() == "scientific") mappedTrack = "track_health";
    if (trackId.toLowerCase() == "literary") mappedTrack = "track_humanities";

    final specific = await getTrackQuestions(mappedTrack);
    return [...global, ...specific];
  }
}
