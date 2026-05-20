import '../models/bilingual_text.dart';

class QuestionnaireQuestion {
  final String id;
  final BilingualText text;
  final String track; // "all", "track_it", "track_health", "track_eng", etc.
  final List<QuestionOption> options;
  final Map<String, double> majorBoosts; // majorId or tag -> points

  QuestionnaireQuestion({
    required this.id,
    required this.text,
    required this.track,
    required this.options,
    this.majorBoosts = const {},
  });
}

class QuestionOption {
  final String key; // "yes", "no", "sometimes"
  final BilingualText text;
  final double scoreMultiplier;

  QuestionOption({
    required this.key,
    required this.text,
    required this.scoreMultiplier,
  });
}

class MockQuestionsData {
  static List<QuestionnaireQuestion> getQuestionsByTrack(String studentTrack) {
    return allQuestions.where((q) => q.track == "all" || q.track == studentTrack).toList();
  }

  static final List<QuestionnaireQuestion> allQuestions = [
    // --- Global Questions (Applicable to all) ---
    QuestionnaireQuestion(
      id: "g1",
      track: "all",
      text: const BilingualText(
        ar: "هل تفضل العمل الميداني والحركي أكثر من العمل المكتبي؟",
        en: "Do you prefer field and physical work over office work?",
      ),
      options: _standardOptions(),
    ),
    QuestionnaireQuestion(
      id: "g2",
      track: "all",
      text: const BilingualText(
        ar: "هل تستمتع بحل المشكلات المعقدة التي تتطلب تفكيراً منطقياً طويلاً؟",
        en: "Do you enjoy solving complex problems that require long logical thinking?",
      ),
      options: _standardOptions(),
    ),

    // --- IT Track Questions ---
    QuestionnaireQuestion(
      id: "it1",
      track: "track_it",
      text: const BilingualText(
        ar: "هل أنت مهتم ببناء أنظمة الذكاء الاصطناعي وفهم كيف يفكر الحاسوب؟",
        en: "Are you interested in building AI systems and understanding how computers think?",
      ),
      options: _standardOptions(),
      majorBoosts: {"artificial intelligence": 10.0, "computer science": 5.0, "software engineering": 3.0, "ذكاء": 10.0, "حاسوب": 5.0, "برمجيات": 3.0},
    ),
    QuestionnaireQuestion(
      id: "it2",
      track: "track_it",
      text: const BilingualText(
        ar: "هل تجد نفسك مهتماً بحماية البيانات واكتشاف الثغرات الأمنية؟",
        en: "Are you interested in data protection and discovering security vulnerabilities?",
      ),
      options: _standardOptions(),
      majorBoosts: {"cyber": 10.0, "security": 10.0, "network": 5.0, "أمن": 10.0, "سيبراني": 10.0, "شبكات": 5.0},
    ),
    QuestionnaireQuestion(
      id: "it3",
      track: "track_it",
      text: const BilingualText(
        ar: "هل تحب تصميم واجهات البرامج والتطبيقات التي يستخدمها الناس؟",
        en: "Do you love designing software and app interfaces that people use?",
      ),
      options: _standardOptions(),
      majorBoosts: {"graphic": 8.0, "design": 8.0, "software": 5.0, "تصميم": 8.0, "جرافيك": 8.0},
    ),
    QuestionnaireQuestion(
      id: "it4",
      track: "track_it",
      text: const BilingualText(
        ar: "هل تفضل التعامل مع الأجهزة والقطع الصلبة (Hardware) أكثر من البرمجة؟",
        en: "Do you prefer dealing with hardware over programming?",
      ),
      options: _standardOptions(),
      majorBoosts: {"computer engineering": 10.0, "network": 5.0, "هندسة حاسوب": 10.0},
    ),

    // --- Health/Medical Track Questions ---
    QuestionnaireQuestion(
      id: "h1",
      track: "track_health",
      text: const BilingualText(
        ar: "هل لديك رغبة قوية في التعامل المباشر مع المرضى وتقديم الرعاية لهم؟",
        en: "Do you have a strong desire to interact directly with patients and provide care?",
      ),
      options: _standardOptions(),
      majorBoosts: {"medicine": 10.0, "nursing": 10.0, "dentistry": 5.0, "طب": 10.0, "تمريض": 10.0, "أسنان": 5.0},
    ),
    QuestionnaireQuestion(
      id: "h2",
      track: "track_health",
      text: const BilingualText(
        ar: "هل تفضل العمل المخبري وتحليل العينات الكيميائية والحيوية؟",
        en: "Do you prefer laboratory work and analyzing chemical and biological samples?",
      ),
      options: _standardOptions(),
      majorBoosts: {"pharmacy": 10.0, "laboratory": 10.0, "صيدلة": 10.0, "مختبرات": 10.0},
    ),
    QuestionnaireQuestion(
      id: "h3",
      track: "track_health",
      text: const BilingualText(
        ar: "هل أنت مهتم بجماليات الابتسامة والعمل اليدوي الدقيق في الفم؟",
        en: "Are you interested in smile aesthetics and delicate manual work in the mouth?",
      ),
      options: _standardOptions(),
      majorBoosts: {"dentistry": 10.0, "أسنان": 10.0},
    ),

    // --- Engineering Track Questions ---
    QuestionnaireQuestion(
      id: "e1",
      track: "track_eng",
      text: const BilingualText(
        ar: "هل تستهويك عملية تصميم المباني والمنشآت الكبيرة؟",
        en: "Are you fascinated by the process of designing buildings and large structures?",
      ),
      options: _standardOptions(),
      majorBoosts: {"architecture": 10.0, "civil": 8.0, "عمارة": 10.0, "مدني": 8.0},
    ),
    QuestionnaireQuestion(
      id: "e2",
      track: "track_eng",
      text: const BilingualText(
        ar: "هل تحب فهم كيفية عمل المحركات والآلات الميكانيكية المعقدة؟",
        en: "Do you love understanding how engines and complex mechanical machines work?",
      ),
      options: _standardOptions(),
      majorBoosts: {"mechanical": 10.0, "mechatronics": 8.0, "ميكانيك": 10.0, "ميكاترونكس": 8.0},
    ),

    // --- Science Track Questions (العلوم العامة) ---
    QuestionnaireQuestion(
      id: "s1",
      track: "track_science",
      text: const BilingualText(
        ar: "هل تستمتع بإجراء التجارب المخبرية وفهم التفاعلات الكيميائية؟",
        en: "Do you enjoy performing lab experiments and understanding chemical reactions?",
      ),
      options: _standardOptions(),
      majorBoosts: {"chemistry": 10.0, "biotechnology": 5.0, "كيمياء": 10.0, "حيوية": 5.0},
    ),
    QuestionnaireQuestion(
      id: "s2",
      track: "track_science",
      text: const BilingualText(
        ar: "هل أنت شغوف بدراسة الكائنات الحية والأنظمة البيئية؟",
        en: "Are you passionate about studying living organisms and ecosystems?",
      ),
      options: _standardOptions(),
      majorBoosts: {"biology": 10.0, "environmental": 8.0, "أحياء": 10.0, "بيئة": 8.0},
    ),
    QuestionnaireQuestion(
      id: "s3",
      track: "track_science",
      text: const BilingualText(
        ar: "هل تحب التعامل مع الأرقام والنظريات الرياضية المعقدة؟",
        en: "Do you like dealing with numbers and complex mathematical theories?",
      ),
      options: _standardOptions(),
      majorBoosts: {"math": 10.0, "physics": 7.0, "رياضيات": 10.0, "فيزياء": 7.0},
    ),

    // --- Business Track Questions (الأعمال والإدارة) ---
    QuestionnaireQuestion(
      id: "b1",
      track: "track_business",
      text: const BilingualText(
        ar: "هل ترى نفسك قائداً ناجحاً وتحب إدارة وتنظيم فرق العمل؟",
        en: "Do you see yourself as a successful leader who loves managing teams?",
      ),
      options: _standardOptions(),
      majorBoosts: {"management": 10.0, "business admin": 8.0, "إدارة": 10.0},
    ),
    QuestionnaireQuestion(
      id: "b2",
      track: "track_business",
      text: const BilingualText(
        ar: "هل لديك اهتمام بمجال المال والأرقام والمحاسبة المالية؟",
        en: "Are you interested in finance, numbers, and financial accounting?",
      ),
      options: _standardOptions(),
      majorBoosts: {"accounting": 10.0, "finance": 8.0, "محاسبة": 10.0, "تمويل": 8.0},
    ),
    QuestionnaireQuestion(
      id: "b3",
      track: "track_business",
      text: const BilingualText(
        ar: "هل تجد نفسك مبدعاً في إقناع الناس وتسويق الأفكار والمنتجات؟",
        en: "Are you creative in persuading people and marketing ideas/products?",
      ),
      options: _standardOptions(),
      majorBoosts: {"marketing": 10.0, "e-commerce": 7.0, "تسويق": 10.0},
    ),

    // --- Law Track Questions (الحقوق) ---
    QuestionnaireQuestion(
      id: "l1",
      track: "track_law",
      text: const BilingualText(
        ar: "هل لديك شغف قوي بالدفاع عن المظلومين وتحقيق العدالة؟",
        en: "Do you have a strong passion for defending the oppressed and achieving justice?",
      ),
      options: _standardOptions(),
      majorBoosts: {"law": 10.0, "justice": 5.0, "حقوق": 10.0, "قانون": 10.0},
    ),
    QuestionnaireQuestion(
      id: "l2",
      track: "track_law",
      text: const BilingualText(
        ar: "هل تستمتع بالمناظرات وقراءة النصوص القانونية والتشريعات؟",
        en: "Do you enjoy debates and reading legal texts and legislation?",
      ),
      options: _standardOptions(),
      majorBoosts: {"law": 10.0, "حقوق": 10.0, "قانون": 10.0},
    ),

    // --- Humanities Track Questions (العلوم الإنسانية) ---
    QuestionnaireQuestion(
      id: "hu1",
      track: "track_humanities",
      text: const BilingualText(
        ar: "هل أنت مهتم بدراسة السلوك البشري وعلم النفس؟",
        en: "Are you interested in studying human behavior and psychology?",
      ),
      options: _standardOptions(),
      majorBoosts: {"psychology": 10.0, "sociology": 7.0, "نفس": 10.0, "اجتماع": 7.0},
    ),
    QuestionnaireQuestion(
      id: "hu2",
      track: "track_humanities",
      text: const BilingualText(
        ar: "هل تحب تعلم اللغات الأجنبية والترجمة بين الثقافات؟",
        en: "Do you love learning foreign languages and cross-cultural translation?",
      ),
      options: _standardOptions(),
      majorBoosts: {"translation": 10.0, "english": 8.0, "french": 8.0, "ترجمة": 10.0, "انجليزي": 8.0},
    ),

    // --- Education Track Questions (التربية) ---
    QuestionnaireQuestion(
      id: "ed1",
      track: "track_edu",
      text: const BilingualText(
        ar: "هل لديك الصبر والقدرة على شرح المعلومات للآخرين بوضوح؟",
        en: "Do you have the patience and ability to explain information clearly?",
      ),
      options: _standardOptions(),
      majorBoosts: {"education": 10.0, "teaching": 8.0, "تربية": 10.0, "تعليم": 8.0},
    ),
    QuestionnaireQuestion(
      id: "ed2",
      track: "track_edu",
      text: const BilingualText(
        ar: "هل تهتم بالتعامل مع الأطفال وتنمية مهاراتهم السلوكية؟",
        en: "Are you interested in dealing with children and developing their behavioral skills?",
      ),
      options: _standardOptions(),
      majorBoosts: {"child": 10.0, "special education": 8.0, "طفل": 10.0, "خاصة": 8.0},
    ),
  ];

  static List<QuestionOption> _standardOptions() {
    return [
      QuestionOption(
        key: "yes",
        text: const BilingualText(ar: "نعم", en: "Yes"),
        scoreMultiplier: 1.0,
      ),
      QuestionOption(
        key: "sometimes",
        text: const BilingualText(ar: "أحياناً", en: "Sometimes"),
        scoreMultiplier: 0.5,
      ),
      QuestionOption(
        key: "no",
        text: const BilingualText(ar: "لا", en: "No"),
        scoreMultiplier: 0.0,
      ),
    ];
  }
}
