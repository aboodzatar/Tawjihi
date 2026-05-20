import '../models/major_model.dart';
import '../models/bilingual_text.dart';

class MockMajorsService {
  static final List<MajorModel> _majors = [
    _createMedicine(),
    _createCS(),
    _createCivilEng(),
    _createCyberSec(),
    _createPharmacy(),
    _createNursing(),
    _createLaw(),
    _createBusinessAdmin(),
    _createAI(),
    _createArchitecture(),
    _createSoftwareEng(),
    _createAccounting(),
    _createGraphicDesign(),
    _createEnglishLit(),
    _createDentistry(),
  ];

  static Future<List<MajorModel>> getAllMajors() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _majors;
  }

  static Future<MajorModel> getMajorById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _majors.firstWhere((m) => m.id == id);
  }

  // --- Specific Major Creators ---

  static MajorModel _createMedicine() {
    return _createBaseMajor(
      "1",
      const BilingualText(ar: "الطب البشري", en: "Medicine"),
      const BilingualText(
        ar: "هذا التخصص مناسب لمن يمتلكون قدراً عالياً من الصبر والرغبة العميقة في مساعدة الآخرين. يتطلب التزاماً بسنوات طويلة من الدراسة والقدرة على العمل تحت ضغط شديد.",
        en: "This major is suitable for those who possess high patience and a deep desire to help others. It requires commitment to long years of study and the ability to work under extreme pressure."
      ),
      const BilingualText(ar: "الجامعة الأردنية", en: "University of Jordan"),
      const BilingualText(ar: "عمان", en: "Amman"),
      "Public", "Regular", "High",
      6,
      [
        const SubjectModel(
          name: BilingualText(ar: "الأحياء", en: "Biology"),
          description: BilingualText(
            ar: "دراسة الكائنات الحية وتفاعلاتها، وهي الأساس لفهم جسم الإنسان.",
            en: "Study of living organisms and their interactions, the basis for understanding the human body."
          ),
        ),
      ],
      "High", 
      const BilingualText(ar: "الدراسة تتطلب حفظاً هائلاً وفهماً دقيقاً.", en: "Study requires massive memorization and precise understanding."),
      "Hard",
      const BilingualText(ar: "صعوبة التخصص تكمن في المسؤولية الكبيرة المرتبطة بحياة البشر.", en: "The difficulty lies in the great responsibility related to human life."),
      [
        const SubjectModel(
          name: BilingualText(ar: "التشخيص", en: "Diagnosis"),
          description: BilingualText(ar: "القدرة على تحليل الأعراض للوصول للمرض الصحيح.", en: "Ability to analyze symptoms to reach the correct disease.")
        ),
        const SubjectModel(
          name: BilingualText(ar: "الجراحة", en: "Surgery"),
          description: BilingualText(ar: "المهارة اليدوية في إجراء العمليات الطبية الدقيقة.", en: "Manual skill in performing delicate medical operations.")
        ),
      ],
      [const BilingualText(ar: "رخصة مزاولة المهنة", en: "Medical License")],
      const BilingualText(ar: "دقيق وصبور", en: "Detail-oriented & Patient"),
      [const BilingualText(ar: "ساعات عمل طويلة", en: "Long working hours")],
      [
        const SubjectModel(name: BilingualText(ar: "طبيب عام", en: "General Practitioner"), description: BilingualText(ar: "تقديم الرعاية الطبية الأساسية وتشخيص الحالات العامة.", en: "Providing basic medical care and diagnosing general cases.")),
      ],
      [const BilingualText(ar: "المستشفيات", en: "Hospitals")],
      "Very High", "Growing",
      "800 - 3000 JD", "Fast", "Stable",
      [const BilingualText(ar: "الجراحة العامة", en: "General Surgery")],
      [const BilingualText(ar: "دكتوراه في الطب", en: "PhD in Medicine")],
      0.2,
      const BilingualText(ar: "عالية جداً", en: "Very High"),
      [const BilingualText(ar: "مكانة اجتماعية", en: "Social Status"), const BilingualText(ar: "دخل مرتفع", en: "High Income")],
      [const BilingualText(ar: "دراسة طويلة", en: "Long study duration")],
      const BilingualText(ar: "من لا يتحمل الدماء", en: "Those who cannot handle blood"),
      "0-6 months", 0.9, 0.3,
      ["health", "science", "biology"], ["patience", "detail"]
    );
  }

  static MajorModel _createCS() {
    return _createBaseMajor(
      "2",
      const BilingualText(ar: "علم الحاسوب", en: "Computer Science"),
      const BilingualText(
        ar: "مثالي لمحبي حل الألغاز والمنطق. هذا التخصص يناسب الشخصيات الفضولية التي تحب التكنولوجيا.",
        en: "Ideal for puzzle solvers and logic lovers. This major suits curious personalities who love technology."
      ),
      const BilingualText(ar: "جامعة الأميرة سمية", en: "PSUT"),
      const BilingualText(ar: "عمان", en: "Amman"),
      "Private", "Regular", "Competitive",
      4,
      [
        const SubjectModel(
          name: BilingualText(ar: "البرمجة", en: "Programming"),
          description: BilingualText(ar: "تعلم لغات التخاطب مع الحاسوب.", en: "Learning languages to communicate with computers.")
        ),
      ],
      "Medium", 
      const BilingualText(ar: "تتطلب تركيزاً ذهنياً عالياً وممارسة مستمرة.", en: "Requires high mental focus and continuous practice."),
      "Moderate",
      const BilingualText(ar: "المفاهيم المنطقية قد تكون صعبة في البداية.", en: "Logical concepts can be difficult at first."),
      [
        const SubjectModel(
          name: BilingualText(ar: "التفكير المنطقي", en: "Logical Thinking"),
          description: BilingualText(ar: "استخدام المنطق لحل المشكلات البرمجية المعقدة.", en: "Using logic to solve complex programming problems.")
        ),
        const SubjectModel(
          name: BilingualText(ar: "حل المشكلات", en: "Problem Solving"),
          description: BilingualText(ar: "إيجاد حلول فعالة للعقبات التقنية.", en: "Finding efficient solutions for technical obstacles.")
        ),
      ],
      [const BilingualText(ar: "AWS Certified", en: "AWS Certified")],
      const BilingualText(ar: "منطقي وفضولي", en: "Logical & Curious"),
      [const BilingualText(ar: "التغير التكنولوجي السريع", en: "Rapid Tech Changes")],
      [
        const SubjectModel(name: BilingualText(ar: "مطور برمجيات", en: "Software Developer"), description: BilingualText(ar: "بناء الأنظمة والتطبيقات البرمجية.", en: "Building software systems and applications.")),
      ],
      [const BilingualText(ar: "شركات التكنولوجيا", en: "Tech Companies")],
      "Very High", "Growing",
      "600 - 2500 JD", "Fast", "Stable",
      [const BilingualText(ar: "الذكاء الاصطناعي", en: "AI")],
      [const BilingualText(ar: "دكتوراه في علم الحاسوب", en: "PhD in CS")],
      0.8,
      const BilingualText(ar: "فرص عالمية", en: "Global Opportunities"),
      [const BilingualText(ar: "رواتب مرتفعة", en: "High Salaries"), const BilingualText(ar: "بيئة عمل مريحة", en: "Comfortable Work Environment")],
      [const BilingualText(ar: "تحتاج جلوس طويل", en: "Requires long sitting hours")],
      const BilingualText(ar: "من لا يحب الرياضيات", en: "Those who dislike math"),
      "0-3 months", 0.9, 0.8,
      ["tech", "logic", "coding"], ["analytical", "curiosity"]
    );
  }

  // --- Helper to reduce boilerplate ---
  static MajorModel _createBaseMajor(
    String id, BilingualText name, BilingualText description, BilingualText uni, BilingualText loc, String uniType, String progType, String chance,
    int duration, List<SubjectModel> subjects, String intensity, BilingualText intensityReason, String difficulty, BilingualText difficultyReason,
    List<SubjectModel> skills, List<BilingualText> certs, BilingualText personality, List<BilingualText> challenges,
    List<SubjectModel> paths, List<BilingualText> envs, String avail, String saturation,
    String income, String growth, String stability,
    List<BilingualText> masters, List<BilingualText> phd, double shiftFlex, BilingualText international,
    List<BilingualText> pros, List<BilingualText> cons, BilingualText notFit,
    String timeToInc, double roi, double flex,
    List<String> tags, List<String> traits
  ) {
    return MajorModel(
      id: id,
      name: name,
      description: description,
      university: uni,
      location: loc,
      universityType: uniType,
      programType: progType,
      predictedChance: chance,
      confidenceScore: 0.95,
      historicalAcceptanceData: const [{"year": 2023, "minGrade": 95.0}, {"year": 2022, "minGrade": 94.5}],
      trendDirection: "Steady",
      duration: duration,
      mainSubjects: subjects,
      studyIntensity: intensity,
      intensityReason: intensityReason,
      difficultyLevel: difficulty,
      difficultyReason: difficultyReason,
      coreSkills: skills,
      certifications: certs,
      suitedPersonality: personality,
      commonChallenges: challenges,
      careerPaths: paths,
      workEnvironments: envs,
      jobAvailability: avail,
      marketSaturation: saturation,
      incomeRange: income,
      incomeGrowth: growth,
      incomeStability: stability,
      mastersSpecializations: masters,
      phdPaths: phd,
      fieldSwitchingFlexibility: shiftFlex,
      internationalOpportunities: international,
      pros: pros,
      cons: cons,
      notSuitableFor: notFit,
      timeToIncome: timeToInc,
      demandVsReturn: roi,
      flexibilityScore: flex,
      trackTags: tags,
      requiredTraits: traits,
      predictedTanafos: 90.0,
      predictedMowazi: 85.0,
      aiDisclaimer: const BilingualText(
        ar: "هذا المعدل تقريبي بناءً على سنوات سابقة وليس الحد الأدنى الحقيقي للسنة القادمة، تم حسابه بواسطة الذكاء الاصطناعي.", 
        en: "AI-generated approximation based on recent years; NOT the official minimum grade for the upcoming year."
      ),
      graduateContacts: [
        GraduateContact(name: const BilingualText(ar: "أحمد علي", en: "Ahmad Ali"), gradYear: 2021, contactInfo: "linkedin.com/in/ahmad"),
      ],
    );
  }

  static MajorModel _createCivilEng() => _createBaseMajor("3", const BilingualText(ar: "الهندسة المدنية", en: "Civil Engineering"), const BilingualText(ar: "يناسب المهتمين بالإنشاءات.", en: "Suits those interested in construction."), const BilingualText(ar: "جامعة العلوم والتكنولوجيا", en: "JUST"), const BilingualText(ar: "اربد", en: "Irbid"), "Public", "Regular", "Ambitious", 5, [], "High", const BilingualText(ar: "", en: ""), "Hard", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "قيادي ودقيق", en: "Leader & Precise"), [], [], [], "Moderate", "Balanced", "500 - 1500 JD", "Steady", "Stable", [], [], 0.4, const BilingualText(ar: "متوسطة", en: "Moderate"), [], [], const BilingualText(ar: "", en: ""), "3-9 months", 0.7, 0.5, ["engineering", "math", "physics"], ["spatial", "logic"]);
  static MajorModel _createCyberSec() => _createBaseMajor("4", const BilingualText(ar: "الأمن السيبراني", en: "Cyber Security"), const BilingualText(ar: "لحماية البيانات.", en: "For data protection."), const BilingualText(ar: "الجامعة الهاشمية", en: "Hashemite University"), const BilingualText(ar: "الزرقاء", en: "Zarqa"), "Public", "Regular", "High", 4, [], "High", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Very High", "Growing", "700 - 3000 JD", "Fast", "Stable", [], [], 0.7, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "0-3 months", 0.9, 0.8, ["tech", "security", "logic"], ["integrity", "curiosity"]);
  static MajorModel _createPharmacy() => _createBaseMajor("12", const BilingualText(ar: "الصيدلة", en: "Pharmacy"), const BilingualText(ar: "للمتممين بالكيمياء.", en: "For biochemistry lovers."), const BilingualText(ar: "الجامعة الهاشمية", en: "Hashemite University"), const BilingualText(ar: "الزرقاء", en: "Zarqa"), "Public", "Regular", "High", 5, [], "Medium", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "High", "Saturated", "500 - 1200 JD", "Steady", "Stable", [], [], 0.5, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "3-6 months", 0.6, 0.4, ["health", "chemistry", "science"], ["memory", "precision"]);
  static MajorModel _createNursing() => _createBaseMajor("7", const BilingualText(ar: "التمريض", en: "Nursing"), const BilingualText(ar: "للقلوب الرحيمة.", en: "For compassionate hearts."), const BilingualText(ar: "جامعة البلقاء التطبيقية", en: "Al-Balqa Applied University"), const BilingualText(ar: "السلط", en: "Salt"), "Public", "Regular", "High", 4, [], "High", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Very High", "Balanced", "400 - 900 JD", "Steady", "Stable", [], [], 0.3, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "0-3 months", 0.8, 0.2, ["health", "empathy", "science"], ["stamina", "care"]);
  static MajorModel _createLaw() => _createBaseMajor("8", const BilingualText(ar: "الحقوق", en: "Law"), const BilingualText(ar: "للباحثين عن العدالة.", en: "For justice seekers."), const BilingualText(ar: "جامعة اليرموك", en: "Yarmouk University"), const BilingualText(ar: "اربد", en: "Irbid"), "Public", "Regular", "High", 4, [], "Medium", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Moderate", "Saturated", "400 - 2000 JD", "Steady", "Stable", [], [], 0.6, const BilingualText(ar: "فرص دولية", en: "International opportunities"), [], [], const BilingualText(ar: "", en: ""), "6-12 months", 0.6, 0.5, ["humanities", "writing", "logic"], ["memory", "ethics"]);
  static MajorModel _createBusinessAdmin() => _createBaseMajor("9", const BilingualText(ar: "إدارة الأعمال", en: "Business Administration"), const BilingualText(ar: "للرياديين.", en: "For entrepreneurs."), const BilingualText(ar: "جامعة مؤتة", en: "Mutah University"), const BilingualText(ar: "الكرك", en: "Karak"), "Public", "Regular", "Competitive", 4, [], "Medium", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "High", "Balanced", "400 - 1500 JD", "Steady", "Stable", [], [], 0.9, const BilingualText(ar: "فرص واسعة", en: "Wide opportunities"), [], [], const BilingualText(ar: "", en: ""), "3-6 months", 0.7, 0.8, ["business", "leadership", "math"], ["outgoing", "organized"]);
  static MajorModel _createAI() => _createBaseMajor("10", const BilingualText(ar: "الذكاء الاصطناعي", en: "AI & Data Science"), const BilingualText(ar: "لمخترعي المستقبل.", en: "For future inventors."), const BilingualText(ar: "الجامعة الأردنية", en: "University of Jordan"), const BilingualText(ar: "عمان", en: "Amman"), "Public", "Regular", "High", 4, [], "High", const BilingualText(ar: "", en: ""), "Hard", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Very High", "Growing", "800 - 3500 JD", "Fast", "Stable", [], [], 0.8, const BilingualText(ar: "طلب عالمي", en: "Global demand"), [], [], const BilingualText(ar: "", en: ""), "0-3 months", 0.95, 0.8, ["tech", "math", "logic"], ["analytical", "curiosity"]);
  static MajorModel _createArchitecture() => _createBaseMajor("6", const BilingualText(ar: "الهندسة المعمارية", en: "Architecture"), const BilingualText(ar: "للمزج بين الفن والرياضيات.", en: "Combining art and math."), const BilingualText(ar: "الجامعة الألمانية الأردنية", en: "German Jordanian University"), const BilingualText(ar: "مادبا", en: "Madaba"), "Public", "Regular", "Ambitious", 5, [], "High", const BilingualText(ar: "", en: ""), "Hard", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Moderate", "Balanced", "500 - 2000 JD", "Steady", "Stable", [], [], 0.5, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "6-12 months", 0.7, 0.6, ["engineering", "art", "design"], ["patience", "creativity"]);
  static MajorModel _createSoftwareEng() => _createBaseMajor("17", const BilingualText(ar: "هندسة البرمجيات", en: "Software Engineering"), const BilingualText(ar: "لبناء الأنظمة المعقدة.", en: "Building complex systems."), const BilingualText(ar: "جامعة الزرقاء", en: "Zarqa University"), const BilingualText(ar: "الزرقاء", en: "Zarqa"), "Private", "Regular", "High", 4, [], "Medium", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Very High", "Growing", "700 - 2800 JD", "Fast", "Stable", [], [], 0.8, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "0-3 months", 0.95, 0.9, ["tech", "logic", "coding"], ["teamwork", "logic"]);
  static MajorModel _createAccounting() => _createBaseMajor("21", const BilingualText(ar: "المحاسبة", en: "Accounting"), const BilingualText(ar: "لدقة الأرقام.", en: "For precise numbers."), const BilingualText(ar: "جامعة البترا", en: "Petra University"), const BilingualText(ar: "عمان", en: "Amman"), "Private", "Regular", "High", 4, [], "Medium", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "High", "Balanced", "400 - 1800 JD", "Steady", "Stable", [], [], 0.8, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "3-6 months", 0.8, 0.7, ["business", "math", "logic"], ["precision", "integrity"]);
  static MajorModel _createGraphicDesign() => _createBaseMajor("20", const BilingualText(ar: "التصميم الجرافيكي", en: "Graphic Design"), const BilingualText(ar: "للمصممين المبدعين.", en: "For creative designers."), const BilingualText(ar: "جامعة العلوم التطبيقية", en: "ASU"), const BilingualText(ar: "عمان", en: "Amman"), "Private", "Regular", "Competitive", 4, [], "Low", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "High", "Growing", "400 - 1500 JD", "Steady", "Variable", [], [], 0.9, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "3-6 months", 0.7, 0.9, ["art", "tech", "design"], ["creativity", "visual"]);
  static MajorModel _createEnglishLit() => _createBaseMajor("16", const BilingualText(ar: "اللغة الإنجليزية وآدابها", en: "English Literature"), const BilingualText(ar: "لمحبي الروايات.", en: "For novel lovers."), const BilingualText(ar: "الجامعة الأردنية", en: "University of Jordan"), const BilingualText(ar: "عمان", en: "Amman"), "Public", "Regular", "High", 4, [], "Low", const BilingualText(ar: "", en: ""), "Moderate", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "Moderate", "Saturated", "350 - 1000 JD", "Slow", "Stable", [], [], 0.7, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "6-12 months", 0.5, 0.6, ["humanities", "writing", "reading"], ["creative", "empathy"]);
  static MajorModel _createDentistry() => _createBaseMajor("13", const BilingualText(ar: "طب الأسنان", en: "Dentistry"), const BilingualText(ar: "للدقة اليدوية.", en: "For manual dexterity."), const BilingualText(ar: "الجامعة الأردنية", en: "University of Jordan"), const BilingualText(ar: "عمان", en: "Amman"), "Public", "Parallel", "Competitive", 5, [], "High", const BilingualText(ar: "", en: ""), "Hard", const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), [], [], [], "High", "Saturated", "700 - 4000 JD", "Steady", "Stable", [], [], 0.3, const BilingualText(ar: "", en: ""), [], [], const BilingualText(ar: "", en: ""), "3-9 months", 0.8, 0.3, ["health", "art", "science"], ["manual-dexterity", "patience"]);
}
