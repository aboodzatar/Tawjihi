class QuestionModel {
  final String id;
  final String textKey; // ARB key
  final List<String> optionsKeys; // ARB keys for options
  final String track; // "static", "health", "engineering", "tech", "humanities", "law", "business"
  final List<String> relatedTags; // Tags this question influences

  QuestionModel({
    required this.id,
    required this.textKey,
    required this.optionsKeys,
    required this.track,
    required this.relatedTags,
  });
}
