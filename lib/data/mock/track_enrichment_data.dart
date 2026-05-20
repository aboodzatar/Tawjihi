import '../models/bilingual_text.dart';
import '../models/major_model.dart';

class TrackEnrichmentData {
  final List<SubjectModel> mainSubjects;
  final List<SubjectModel> coreSkills;
  final List<SubjectModel> careerPaths;
  final List<BilingualText> workEnvironments;
  final String jobAvailability;
  final String marketSaturation;
  final String incomeRange;
  final String incomeGrowth;
  final String incomeStability;
  final List<BilingualText> mastersSpecializations;
  final BilingualText internationalOpportunities;
  final List<BilingualText> pros;
  final List<BilingualText> cons;
  final BilingualText notSuitableFor;
  final BilingualText suitedPersonality;
  final String studyIntensity;
  final BilingualText intensityReason;
  final String difficultyLevel;
  final BilingualText difficultyReason;
  final String timeToIncome;
  final double demandVsReturn;
  final double flexibilityScore;

  const TrackEnrichmentData({
    required this.mainSubjects,
    required this.coreSkills,
    required this.careerPaths,
    required this.workEnvironments,
    required this.jobAvailability,
    required this.marketSaturation,
    required this.incomeRange,
    required this.incomeGrowth,
    required this.incomeStability,
    required this.mastersSpecializations,
    required this.internationalOpportunities,
    required this.pros,
    required this.cons,
    required this.notSuitableFor,
    required this.suitedPersonality,
    required this.studyIntensity,
    required this.intensityReason,
    required this.difficultyLevel,
    required this.difficultyReason,
    required this.timeToIncome,
    required this.demandVsReturn,
    required this.flexibilityScore,
  });
}

class TrackEnrichment {
  static TrackEnrichmentData getByTrack(String trackId) {
    return _data[trackId] ?? _data['track_it']!;
  }

  static const _data = <String, TrackEnrichmentData>{
    'track_eng': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'رياضيات هندسية', en: 'Engineering Math'), description: BilingualText(ar: 'تطبيقات الرياضيات المتقدمة في حل المشكلات الهندسية المعقدة.', en: 'Advanced math applications in solving complex engineering problems.')),
        SubjectModel(name: BilingualText(ar: 'فيزياء', en: 'Physics'), description: BilingualText(ar: 'فهم القوانين الطبيعية التي تحكم المادة والطاقة والقوى.', en: 'Understanding natural laws governing matter, energy, and forces.')),
        SubjectModel(name: BilingualText(ar: 'ميكانيكا', en: 'Mechanics'), description: BilingualText(ar: 'دراسة حركة الأجسام والقوى المؤثرة عليها.', en: 'Study of body motion and the forces acting upon them.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'حل المشكلات', en: 'Problem Solving'), description: BilingualText(ar: 'القدرة على تحليل العقبات الهندسية وإيجاد حلول مبتكرة.', en: 'The ability to analyze engineering obstacles and find innovative solutions.')),
        SubjectModel(name: BilingualText(ar: 'تفكير تحليلي', en: 'Analytical Thinking'), description: BilingualText(ar: 'استخدام المنطق والبيانات لاتخاذ قرارات تقنية دقيقة.', en: 'Using logic and data to make precise technical decisions.')),
        SubjectModel(name: BilingualText(ar: 'تصميم هندسي', en: 'Engineering Design'), description: BilingualText(ar: 'بناء المخططات والنماذج الأولية للمشاريع باستخدام أدوات متطورة.', en: 'Building blueprints and prototypes for projects using advanced tools.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'مهندس مدني', en: 'Civil Engineer'), description: BilingualText(ar: 'تصميم وإدارة مشاريع البنية التحتية مثل الطرق والجسور والمباني.', en: 'Designing and managing infrastructure projects like roads, bridges, and buildings.')),
        SubjectModel(name: BilingualText(ar: 'مهندس كهربائي', en: 'Electrical Engineer'), description: BilingualText(ar: 'تطوير وصيانة أنظمة الطاقة والدوائر الكهربائية والأنظمة الإلكترونية.', en: 'Developing and maintaining power systems, electrical circuits, and electronic systems.')),
        SubjectModel(name: BilingualText(ar: 'مهندس ميكانيكي', en: 'Mechanical Engineer'), description: BilingualText(ar: 'تصميم وتصنيع المحركات والآلات وأنظمة التحكم الميكانيكية.', en: 'Designing and manufacturing engines, machines, and mechanical control systems.')),
        SubjectModel(name: BilingualText(ar: 'مهندس برمجيات', en: 'Software Engineer'), description: BilingualText(ar: 'بناء الأنظمة البرمجية المعقدة وحل المشكلات التقنية باستخدام الكود.', en: 'Building complex software systems and solving technical problems using code.')),
        SubjectModel(name: BilingualText(ar: 'مستشار هندسي', en: 'Engineering Consultant'), description: BilingualText(ar: 'تقديم الخبرة الفنية والحلول للمشاكل الهندسية في المشاريع الكبرى.', en: 'Providing technical expertise and solutions for engineering problems in major projects.')),
        SubjectModel(name: BilingualText(ar: 'مدير مشاريع', en: 'Project Manager'), description: BilingualText(ar: 'التخطيط والتنسيق بين الفرق لضمان تسليم المشاريع في وقتها وبالجودة المطلوبة.', en: 'Planning and coordinating between teams to ensure project delivery on time and with required quality.')),
      ],
      workEnvironments: [BilingualText(ar: 'مكتب هندسي', en: 'Engineering Office'), BilingualText(ar: 'موقع بناء', en: 'Construction Site'), BilingualText(ar: 'مصنع', en: 'Factory'), BilingualText(ar: 'قطاع حكومي', en: 'Government Sector')],
      jobAvailability: 'مرتفع / High',
      marketSaturation: 'متوسط / Moderate',
      incomeRange: '700–1800 JOD',
      incomeGrowth: 'تصاعدي / Rising',
      incomeStability: 'مستقر / Stable',
      mastersSpecializations: [BilingualText(ar: 'هندسة إنشائية', en: 'Structural Engineering'), BilingualText(ar: 'هندسة بيئية', en: 'Environmental Engineering'), BilingualText(ar: 'إدارة المشاريع', en: 'Project Management'), BilingualText(ar: 'هندسة الحاسوب', en: 'Computer Engineering')],
      internationalOpportunities: BilingualText(ar: 'فرص ممتازة في الخليج وأوروبا وكندا', en: 'Excellent opportunities in Gulf, Europe & Canada'),
      pros: [BilingualText(ar: 'رواتب مرتفعة', en: 'High salaries'), BilingualText(ar: 'طلب متزايد', en: 'Growing demand'), BilingualText(ar: 'تنوع التخصصات', en: 'Wide specializations'), BilingualText(ar: 'احترام اجتماعي', en: 'Social prestige'), BilingualText(ar: 'مشاريع مؤثرة', en: 'Impactful projects')],
      cons: [BilingualText(ar: 'ساعات دراسة طويلة', en: 'Long study hours'), BilingualText(ar: 'ضغط عالٍ', en: 'High pressure'), BilingualText(ar: 'متطلبات رياضية قوية', en: 'Strong math required')],
      notSuitableFor: BilingualText(
        ar: 'الأشخاص الذين يفضلون العمل النظري البحت ولا يستمتعون بحل المسائل الرياضية المعقدة، أو أولئك الذين يجدون صعوبة في التعامل مع المشاريع الهندسية الطويلة التي تتطلب تركيزاً ذهنياً عالياً ومتابعة دقيقة للتفاصيل.',
        en: 'Individuals who prefer purely theoretical work and do not enjoy solving complex mathematical problems, or those who find it difficult to handle long engineering projects that require high mental focus and precise attention to detail.'
      ),
      suitedPersonality: BilingualText(ar: 'تحليلي منطقي يحب حل المشكلات', en: 'Analytical, logical, problem-solver'),
      studyIntensity: 'مكثف / Intensive',
      intensityReason: BilingualText(ar: 'يتطلب ساعات طويلة من حل المسائل والمشاريع العملية.', en: 'Requires long hours of problem solving and practical projects.'),
      difficultyLevel: 'صعب / Hard',
      difficultyReason: BilingualText(ar: 'المفاهيم الفيزيائية والرياضية المتقدمة تحتاج لتركيز ذهني كبير.', en: 'Advanced physical and mathematical concepts require great mental focus.'),
      timeToIncome: '6 أشهر / 6 Months',
      demandVsReturn: 0.87,
      flexibilityScore: 0.72,
    ),
    'track_it': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'أساسيات البرمجة', en: 'Programming Fundamentals'), description: BilingualText(ar: 'تعلم لغات البرمجة وكيفية التفكير المنطقي لبناء الأنظمة.', en: 'Learning programming languages and logical thinking to build systems.')),
        SubjectModel(name: BilingualText(ar: 'ذكاء اصطناعي', en: 'Artificial Intelligence'), description: BilingualText(ar: 'دراسة كيفية جعل الآلات تحاكي الذكاء البشري.', en: 'Studying how to make machines simulate human intelligence.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'برمجة', en: 'Programming'), description: BilingualText(ar: 'كتابة الأكواد بلغات مختلفة لبناء التطبيقات والمواقع.', en: 'Writing code in different languages to build apps and websites.')),
        SubjectModel(name: BilingualText(ar: 'تحليل البيانات', en: 'Data Analysis'), description: BilingualText(ar: 'استخراج الأنماط والمعلومات من كميات كبيرة من البيانات.', en: 'Extracting patterns and information from large amounts of data.')),
        SubjectModel(name: BilingualText(ar: 'تفكير خوارزمي', en: 'Algorithmic Thinking'), description: BilingualText(ar: 'تصميم خطوات منطقية وفعالة لحل المشكلات المعقدة.', en: 'Designing logical and efficient steps to solve complex problems.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'مطور برمجيات', en: 'Software Developer'), description: BilingualText(ar: 'تصميم وكتابة الأكواد لبناء تطبيقات ومواقع وأنظمة ذكية.', en: 'Designing and writing code to build apps, websites, and smart systems.')),
        SubjectModel(name: BilingualText(ar: 'مهندس شبكات', en: 'Network Engineer'), description: BilingualText(ar: 'بناء وصيانة البنية التحتية للاتصالات والشبكات داخل المؤسسات.', en: 'Building and maintaining communication infrastructure and networks within institutions.')),
        SubjectModel(name: BilingualText(ar: 'محلل بيانات', en: 'Data Analyst'), description: BilingualText(ar: 'تحويل البيانات الخام إلى رؤى ومعلومات تساعد في اتخاذ القرارات.', en: 'Transforming raw data into insights and information that help in decision making.')),
        SubjectModel(name: BilingualText(ar: 'متخصص أمن معلومات', en: 'Security Specialist'), description: BilingualText(ar: 'حماية الأنظمة والبيانات من الاختراقات والهجمات السيبرانية.', en: 'Protecting systems and data from breaches and cyber attacks.')),
        SubjectModel(name: BilingualText(ar: 'مطور تطبيقات', en: 'App Developer'), description: BilingualText(ar: 'تطوير تطبيقات الهواتف الذكية (Android/iOS) باستخدام تقنيات حديثة.', en: 'Developing smartphone applications (Android/iOS) using modern technologies.')),
        SubjectModel(name: BilingualText(ar: 'مهندس ذكاء اصطناعي', en: 'AI Engineer'), description: BilingualText(ar: 'بناء نماذج تعتمد على تعلم الآلة لتحليل البيانات وتوقع النتائج.', en: 'Building models based on machine learning to analyze data and predict results.')),
      ],
      workEnvironments: [BilingualText(ar: 'شركات تقنية', en: 'Tech Companies'), BilingualText(ar: 'عمل عن بعد', en: 'Remote Work'), BilingualText(ar: 'شركات ناشئة', en: 'Startups'), BilingualText(ar: 'قطاع حكومي', en: 'Government IT')],
      jobAvailability: 'مرتفع جداً / Very High',
      marketSaturation: 'مرتفع / High',
      incomeRange: '600–2000 JOD',
      incomeGrowth: 'تصاعدي سريع / Fast Rising',
      incomeStability: 'مستقر / Stable',
      mastersSpecializations: [BilingualText(ar: 'أمن المعلومات', en: 'Cybersecurity'), BilingualText(ar: 'الذكاء الاصطناعي', en: 'Artificial Intelligence'), BilingualText(ar: 'علم البيانات', en: 'Data Science'), BilingualText(ar: 'هندسة البرمجيات', en: 'Software Engineering')],
      internationalOpportunities: BilingualText(ar: 'فرص عالمية واسعة وإمكانية العمل عن بعد', en: 'Global opportunities with remote work flexibility'),
      pros: [BilingualText(ar: 'طلب عالمي ضخم', en: 'Massive global demand'), BilingualText(ar: 'رواتب تنافسية', en: 'Competitive salaries'), BilingualText(ar: 'إمكانية العمل الحر', en: 'Freelancing potential'), BilingualText(ar: 'تطور مستمر', en: 'Continuous growth'), BilingualText(ar: 'مرونة مكان العمل', en: 'Workplace flexibility')],
      cons: [BilingualText(ar: 'تطور سريع يتطلب تعلماً مستمراً', en: 'Fast changes require constant learning'), BilingualText(ar: 'ضغط مواعيد التسليم', en: 'Deadline pressure'), BilingualText(ar: 'منافسة عالية', en: 'High competition')],
      notSuitableFor: BilingualText(
        ar: 'الأفراد الذين لا يميلون للتفكير التقني المنطقي أو يجدون صعوبة في التعلم الذاتي المستمر، حيث أن هذا المجال يتطور بسرعة هائلة وتتغير تقنياته باستمرار مما يتطلب شغفاً دائماً بمواكبة كل ما هو جديد.',
        en: 'Individuals who are not inclined towards logical technical thinking or find difficulty in continuous self-learning, as this field evolves rapidly and its technologies change constantly, requiring a permanent passion for keeping up with everything new.'
      ),
      suitedPersonality: BilingualText(ar: 'فضولي يحب التقنية ويستمتع ببناء الأنظمة', en: 'Curious, tech-passionate, enjoys building systems'),
      studyIntensity: 'مكثف / Intensive',
      intensityReason: BilingualText(ar: 'يتطلب ممارسة يومية وتطبيق عملي مستمر لمواكبة التقنيات.', en: 'Requires daily practice and continuous practical application to keep up with technologies.'),
      difficultyLevel: 'متوسط–صعب / Medium–Hard',
      difficultyReason: BilingualText(ar: 'الصعوبة تكمن في تجريد المفاهية البرمجية وحل المشكلات المعقدة.', en: 'Difficulty lies in abstracting programming concepts and solving complex problems.'),
      timeToIncome: '3 أشهر / 3 Months',
      demandVsReturn: 0.91,
      flexibilityScore: 0.88,
    ),
    'track_business': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'إدارة الأعمال', en: 'Business Management'), description: BilingualText(ar: 'فهم كيفية تنظيم وقيادة المؤسسات لتحقيق الأهداف.', en: 'Understanding how to organize and lead institutions to achieve goals.')),
        SubjectModel(name: BilingualText(ar: 'المحاسبة المالية', en: 'Financial Accounting'), description: BilingualText(ar: 'تعلم كيفية تسجيل العمليات المالية وإعداد القوائم الختامية.', en: 'Learning how to record financial transactions and prepare final statements.')),
        SubjectModel(name: BilingualText(ar: 'مبادئ التسويق', en: 'Marketing Principles'), description: BilingualText(ar: 'دراسة سلوك المستهلك وكيفية بناء استراتيجيات البيع والترويج.', en: 'Studying consumer behavior and how to build sales and promotion strategies.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'تواصل فعال', en: 'Effective Communication'), description: BilingualText(ar: 'القدرة على نقل الأفكار بوضوح والتفاوض بنجاح.', en: 'The ability to convey ideas clearly and negotiate successfully.')),
        SubjectModel(name: BilingualText(ar: 'تفكير استراتيجي', en: 'Strategic Thinking'), description: BilingualText(ar: 'التخطيط طويل الأمد لتحقيق رؤية وأهداف المؤسسة.', en: 'Long-term planning to achieve the organizations vision and goals.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'محاسب', en: 'Accountant'), description: BilingualText(ar: 'تسجيل العمليات المالية وإعداد التقارير الضريبية والميزانيات.', en: 'Recording financial operations and preparing tax reports and budgets.')),
        SubjectModel(name: BilingualText(ar: 'مدير مالي', en: 'Financial Manager'), description: BilingualText(ar: 'الإشراف على الصحة المالية للمؤسسة وإدارة الاستثمارات.', en: 'Overseeing the organizations financial health and managing investments.')),
        SubjectModel(name: BilingualText(ar: 'مسوّق', en: 'Marketer'), description: BilingualText(ar: 'بناء العلامة التجارية وجذب العملاء باستخدام حملات إبداعية.', en: 'Building the brand and attracting customers using creative campaigns.')),
        SubjectModel(name: BilingualText(ar: 'محلل أعمال', en: 'Business Analyst'), description: BilingualText(ar: 'دراسة السوق وتحسين عمليات الشركة لزيادة الربحية.', en: 'Studying the market and improving company operations to increase profitability.')),
        SubjectModel(name: BilingualText(ar: 'مدير موارد بشرية', en: 'HR Manager'), description: BilingualText(ar: 'إدارة شؤون الموظفين من التوظيف وحتى التدريب والتطوير.', en: 'Managing employee affairs from recruitment to training and development.')),
        SubjectModel(name: BilingualText(ar: 'مستشار إداري', en: 'Management Consultant'), description: BilingualText(ar: 'تقديم نصائح مهنية لتحسين أداء وكفاءة المؤسسات.', en: 'Providing professional advice to improve the performance and efficiency of institutions.')),
      ],
      workEnvironments: [BilingualText(ar: 'مكاتب الشركات', en: 'Corporate Offices'), BilingualText(ar: 'بنوك', en: 'Banks'), BilingualText(ar: 'شركات ناشئة', en: 'Startups'), BilingualText(ar: 'مؤسسات حكومية', en: 'Government Institutions')],
      jobAvailability: 'متوسط–مرتفع / Medium–High',
      marketSaturation: 'مرتفع / High',
      incomeRange: '500–1400 JOD',
      incomeGrowth: 'ثابت مع نمو / Steady with Growth',
      incomeStability: 'مستقر / Stable',
      mastersSpecializations: [BilingualText(ar: 'ماجستير إدارة الأعمال MBA', en: 'MBA'), BilingualText(ar: 'مالية', en: 'Finance'), BilingualText(ar: 'تسويق رقمي', en: 'Digital Marketing'), BilingualText(ar: 'ريادة الأعمال', en: 'Entrepreneurship')],
      internationalOpportunities: BilingualText(ar: 'فرص في الخليج والأسواق الدولية', en: 'Opportunities in Gulf & international markets'),
      pros: [BilingualText(ar: 'تنوع مسارات العمل', en: 'Diverse career paths'), BilingualText(ar: 'مهارات قابلة للتحويل', en: 'Transferable skills'), BilingualText(ar: 'إمكانية ريادة الأعمال', en: 'Entrepreneurship opportunity'), BilingualText(ar: 'طلب ثابت', en: 'Consistent demand')],
      cons: [BilingualText(ar: 'سوق مشبع بالخريجين', en: 'Saturated graduate market'), BilingualText(ar: 'منافسة عالية', en: 'High competition'), BilingualText(ar: 'قد تبدأ الرواتب منخفضة', en: 'Salaries may start low')],
      notSuitableFor: BilingualText(
        ar: 'من يبحث عن عمل تقني أو علمي منعزل ولا يمتلك الرغبة في تطوير مهارات التواصل والتفاوض، أو أولئك الذين لا يفضلون العمل في بيئات تنافسية تتطلب تخطيطاً استراتيجياً وتعاوناً دائماً مع فرق العمل المختلفة.',
        en: 'Those looking for isolated technical or scientific work and lacking the desire to develop communication and negotiation skills, or individuals who do not prefer working in competitive environments that require strategic planning and constant cooperation with different teams.'
      ),
      suitedPersonality: BilingualText(ar: 'شخص اجتماعي طموح يحب الأرقام والناس', en: 'Social, ambitious, enjoys numbers & people'),
      studyIntensity: 'متوسط / Moderate',
      intensityReason: BilingualText(ar: 'يعتمد على القراءة والتحليل وإدارة المشاريع الصغيرة.', en: 'Relies on reading, analysis, and managing small projects.'),
      difficultyLevel: 'متوسط / Medium',
      difficultyReason: BilingualText(ar: 'المفاهيم الإدارية سهلة الفهم لكن تطبيقها يحتاج لمهارات شخصية.', en: 'Management concepts are easy to understand but application requires personal skills.'),
      timeToIncome: '3–6 أشهر / 3–6 Months',
      demandVsReturn: 0.74,
      flexibilityScore: 0.82,
    ),
    'track_science': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'كيمياء عامة', en: 'General Chemistry'), description: BilingualText(ar: 'دراسة تركيب المادة وخصائصها وتفاعلاتها.', en: 'Study of matter composition, properties, and reactions.')),
        SubjectModel(name: BilingualText(ar: 'فيزياء حديثة', en: 'Modern Physics'), description: BilingualText(ar: 'فهم القوانين الفيزيائية التي تحكم الكون في المستويات الذرية والكونية.', en: 'Understanding physical laws governing the universe at atomic and cosmic levels.')),
        SubjectModel(name: BilingualText(ar: 'تحليل رياضي', en: 'Mathematical Analysis'), description: BilingualText(ar: 'استخدام التفاضل والتكامل لفهم الأنظمة العلمية المتغيرة.', en: 'Using calculus and integration to understand changing scientific systems.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'بحث علمي', en: 'Scientific Research'), description: BilingualText(ar: 'اتباع المنهج العلمي لاستكشاف الظواهر وإثبات النظريات.', en: 'Following the scientific method to explore phenomena and prove theories.')),
        SubjectModel(name: BilingualText(ar: 'تحليل مختبري', en: 'Lab Analysis'), description: BilingualText(ar: 'استخدام الأدوات الدقيقة لتحليل العينات وتسجيل النتائج.', en: 'Using precise tools to analyze samples and record results.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'باحث علمي', en: 'Research Scientist'), description: BilingualText(ar: 'العمل في مراكز الأبحاث لاستكشاف اكتشافات علمية جديدة.', en: 'Working in research centers to explore new scientific discoveries.')),
        SubjectModel(name: BilingualText(ar: 'كيميائي', en: 'Chemist'), description: BilingualText(ar: 'تحليل المواد الكيميائية وتطوير مركبات جديدة للصناعة أو الطب.', en: 'Analyzing chemicals and developing new compounds for industry or medicine.')),
        SubjectModel(name: BilingualText(ar: 'بيولوجي', en: 'Biologist'), description: BilingualText(ar: 'دراسة الكائنات الحية وتفاعلاتها مع البيئة.', en: 'Studying living organisms and their interactions with the environment.')),
        SubjectModel(name: BilingualText(ar: 'فيزيائي', en: 'Physicist'), description: BilingualText(ar: 'دراسة المادة والطاقة والقوانين التي تحكم الكون.', en: 'Studying matter, energy, and the laws that govern the universe.')),
        SubjectModel(name: BilingualText(ar: 'محلل مختبري', en: 'Lab Analyst'), description: BilingualText(ar: 'إجراء الفحوصات المختبرية لضمان جودة المنتجات أو صحة العينات.', en: 'Performing lab tests to ensure product quality or sample health.')),
        SubjectModel(name: BilingualText(ar: 'أكاديمي', en: 'Academic'), description: BilingualText(ar: 'التدريس والبحث العلمي في الجامعات والمؤسسات التعليمية.', en: 'Teaching and scientific research in universities and educational institutions.')),
      ],
      workEnvironments: [BilingualText(ar: 'مختبرات بحثية', en: 'Research Labs'), BilingualText(ar: 'جامعات', en: 'Universities'), BilingualText(ar: 'شركات أدوية', en: 'Pharmaceutical Companies'), BilingualText(ar: 'مؤسسات حكومية', en: 'Government Agencies')],
      jobAvailability: 'متوسط / Moderate',
      marketSaturation: 'متوسط / Moderate',
      incomeRange: '450–1200 JOD',
      incomeGrowth: 'ثابت / Steady',
      incomeStability: 'متوسط / Moderate',
      mastersSpecializations: [BilingualText(ar: 'كيمياء تحليلية', en: 'Analytical Chemistry'), BilingualText(ar: 'علم الأحياء الجزيئي', en: 'Molecular Biology'), BilingualText(ar: 'فيزياء تطبيقية', en: 'Applied Physics'), BilingualText(ar: 'دكتوراه بحث', en: 'Research PhD')],
      internationalOpportunities: BilingualText(ar: 'فرص بحثية دولية وبرامج تبادل جامعي', en: 'International research & university exchange programs'),
      pros: [BilingualText(ar: 'عمل فكري ممتع', en: 'Intellectually rewarding work'), BilingualText(ar: 'مساهمة في العلم', en: 'Contributing to science'), BilingualText(ar: 'إمكانية التدريس', en: 'Teaching possibility'), BilingualText(ar: 'أكاديميات وأبحاث', en: 'Academia & research')],
      cons: [BilingualText(ar: 'رواتب بداية متدنية', en: 'Low starting salaries'), BilingualText(ar: 'فرص عمل محدودة محلياً', en: 'Limited local jobs'), BilingualText(ar: 'يتطلب دراسات عليا للتقدم', en: 'Advanced degrees needed to advance')],
      notSuitableFor: BilingualText(
        ar: 'الأشخاص الذين يسعون لتحقيق عائد مادي سريع جداً دون الرغبة في إكمال الدراسات العليا والأبحاث الطويلة، أو من لا يمتلك الصبر الكافي للعمل في المختبرات والتعامل مع النتائج العلمية التي قد تستغرق وقتاً طويلاً للوصول إليها.',
        en: 'People who seek very quick financial returns without the desire to complete postgraduate studies and long research, or those who do not have enough patience to work in laboratories and deal with scientific results that may take a long time to reach.'
      ),
      suitedPersonality: BilingualText(ar: 'فضولي يحب الاستكشاف والبحث والتجريب', en: 'Curious, loves exploration, research & experimentation'),
      studyIntensity: 'مكثف / Intensive',
      intensityReason: BilingualText(ar: 'يتطلب تجارب مختبرية طويلة ودقة عالية في الملاحظة.', en: 'Requires long lab experiments and high precision in observation.'),
      difficultyLevel: 'صعب / Hard',
      difficultyReason: BilingualText(ar: 'التعقيد يكمن في النظريات العلمية العميقة والحسابات الدقيقة.', en: 'Complexity lies in deep scientific theories and precise calculations.'),
      timeToIncome: '12+ أشهر / 12+ Months',
      demandVsReturn: 0.61,
      flexibilityScore: 0.65,
    ),
    'track_health': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'تشريح', en: 'Anatomy'), description: BilingualText(ar: 'دراسة هيكل الجسم البشري وأعضائه بالتفصيل.', en: 'Detailed study of the human body structure and its organs.')),
        SubjectModel(name: BilingualText(ar: 'علم وظائف الأعضاء', en: 'Physiology'), description: BilingualText(ar: 'فهم كيفية عمل أجهزة الجسم المختلفة وتفاعلها معاً.', en: 'Understanding how different body systems function and interact together.')),
        SubjectModel(name: BilingualText(ar: 'علم الأدوية', en: 'Pharmacology'), description: BilingualText(ar: 'دراسة تأثير الأدوية على الجسم وكيفية استخدامها في العلاج.', en: 'Studying drug effects on the body and how to use them in treatment.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'تشخيص طبي', en: 'Medical Diagnosis'), description: BilingualText(ar: 'القدرة على تحديد الأمراض بناءً على الأعراض والفحوصات.', en: 'The ability to identify diseases based on symptoms and tests.')),
        SubjectModel(name: BilingualText(ar: 'رعاية المرضى', en: 'Patient Care'), description: BilingualText(ar: 'تقديم الدعم الطبي والنفسي اللازم للمرضى أثناء العلاج.', en: 'Providing necessary medical and psychological support to patients during treatment.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'طبيب', en: 'Physician'), description: BilingualText(ar: 'تقديم الرعاية الصحية الأولية أو المتخصصة وتشخيص الأمراض وعلاجها.', en: 'Providing primary or specialized healthcare, diagnosing diseases, and treating them.')),
        SubjectModel(name: BilingualText(ar: 'صيدلاني', en: 'Pharmacist'), description: BilingualText(ar: 'إدارة وصرف الأدوية وتقديم المشورة للمرضى حول الاستخدام الصحيح.', en: 'Managing and dispensing medications and advising patients on correct use.')),
        SubjectModel(name: BilingualText(ar: 'ممرض', en: 'Nurse'), description: BilingualText(ar: 'متابعة الحالة الصحية للمرضى وتقديم الرعاية اليومية اللازمة.', en: 'Monitoring patients health status and providing necessary daily care.')),
        SubjectModel(name: BilingualText(ar: 'أخصائي مختبرات', en: 'Lab Specialist'), description: BilingualText(ar: 'تحليل العينات الطبية للمساعدة في تشخيص الحالات بدقة.', en: 'Analyzing medical samples to help diagnose cases accurately.')),
        SubjectModel(name: BilingualText(ar: 'فيزيائي طبي', en: 'Medical Physicist'), description: BilingualText(ar: 'تطبيق مفاهيم الفيزياء في الطب، مثل الأشعة والعلاج الإشعاعي.', en: 'Applying physics concepts in medicine, such as radiology and radiation therapy.')),
        SubjectModel(name: BilingualText(ar: 'مدير مستشفى', en: 'Hospital Administrator'), description: BilingualText(ar: 'إدارة الجوانب التشغيلية والمالية للمنشآت الصحية.', en: 'Managing the operational and financial aspects of health facilities.')),
      ],
      workEnvironments: [BilingualText(ar: 'مستشفيات', en: 'Hospitals'), BilingualText(ar: 'عيادات', en: 'Clinics'), BilingualText(ar: 'مختبرات', en: 'Laboratories'), BilingualText(ar: 'صيدليات', en: 'Pharmacies')],
      jobAvailability: 'مرتفع جداً / Very High',
      marketSaturation: 'متوسط / Moderate',
      incomeRange: '800–4000 JOD',
      incomeGrowth: 'مستقر ومتصاعد / Stable & Rising',
      incomeStability: 'عالٍ جداً / Very High',
      mastersSpecializations: [BilingualText(ar: 'تخصصات طبية', en: 'Medical Specializations'), BilingualText(ar: 'صحة عامة', en: 'Public Health'), BilingualText(ar: 'إدارة صحية', en: 'Health Management'), BilingualText(ar: 'طب طوارئ', en: 'Emergency Medicine')],
      internationalOpportunities: BilingualText(ar: 'فرص واسعة في الخليج وأوروبا وكندا', en: 'Wide opportunities in Gulf, Europe & Canada'),
      pros: [BilingualText(ar: 'وظيفة نبيلة ومؤثرة', en: 'Noble & impactful career'), BilingualText(ar: 'رواتب عالية جداً', en: 'Very high salaries'), BilingualText(ar: 'استقرار وظيفي دائم', en: 'Permanent job stability'), BilingualText(ar: 'احترام اجتماعي كبير', en: 'High social prestige')],
      cons: [BilingualText(ar: 'سنوات دراسة طويلة جداً', en: 'Very long study years'), BilingualText(ar: 'ضغط عمل شديد', en: 'Intense work pressure'), BilingualText(ar: 'مسؤولية أخلاقية عالية', en: 'High ethical responsibility'), BilingualText(ar: 'وقت فراغ محدود', en: 'Limited leisure time')],
      notSuitableFor: BilingualText(
        ar: 'الأفراد الذين يجدون صعوبة في التعامل مع الضغوط النفسية والجسدية الشديدة أو من لا يمتلكون الاستعداد لتحمل مسؤولية حياة البشر بشكل مباشر، نظراً لما يتطلبه هذا العمل من دقة متناهية وساعات عمل طويلة ومرهقة.',
        en: 'Individuals who find it difficult to deal with extreme psychological and physical pressures, or those who are not ready to take direct responsibility for human lives, given that this work requires extreme precision and long, exhausting working hours.'
      ),
      suitedPersonality: BilingualText(ar: 'متعاطف صبور يتحمل الضغط ويرغب بمساعدة الآخرين', en: 'Empathetic, patient, handles pressure & wants to help others'),
      studyIntensity: 'مكثف جداً / Very Intensive',
      intensityReason: BilingualText(ar: 'يتطلب حفظ كميات ضخمة من المعلومات والتواجد الدائم في المستشفيات.', en: 'Requires memorizing massive amounts of information and constant hospital presence.'),
      difficultyLevel: 'صعب جداً / Very Hard',
      difficultyReason: BilingualText(ar: 'حياة البشر تعتمد على دقة معرفتك وقراراتك السريعة.', en: 'Human lives depend on your knowledge precision and quick decisions.'),
      timeToIncome: '12–24 شهر / 12–24 Months',
      demandVsReturn: 0.93,
      flexibilityScore: 0.55,
    ),
    'track_law': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'مبادئ القانون', en: 'Principles of Law'), description: BilingualText(ar: 'الأساس الذي تقوم عليه جميع الأنظمة القانونية.', en: 'The foundation upon which all legal systems are built.')),
        SubjectModel(name: BilingualText(ar: 'القانون المدني', en: 'Civil Law'), description: BilingualText(ar: 'دراسة القواعد التي تنظم العلاقات بين الأفراد.', en: 'Studying rules that regulate relationships between individuals.')),
        SubjectModel(name: BilingualText(ar: 'القانون الجنائي', en: 'Criminal Law'), description: BilingualText(ar: 'فهم التشريعات المتعلقة بالجرائم والعقوبات.', en: 'Understanding legislation related to crimes and punishments.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'تحليل قانوني', en: 'Legal Analysis'), description: BilingualText(ar: 'دراسة النصوص القانونية واستنباط الأحكام منها بدقة.', en: 'Studying legal texts and deriving rulings from them accurately.')),
        SubjectModel(name: BilingualText(ar: 'إقناع وخطابة', en: 'Persuasion & Oratory'), description: BilingualText(ar: 'القدرة على بناء حجج قوية وعرضها بوضوح أمام المحاكم.', en: 'The ability to build strong arguments and present them clearly before courts.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'محامي', en: 'Lawyer'), description: BilingualText(ar: 'تمثيل الموكلين والدفاع عنهم في القضايا القانونية أمام المحاكم.', en: 'Representing and defending clients in legal cases before courts.')),
        SubjectModel(name: BilingualText(ar: 'قاضي', en: 'Judge'), description: BilingualText(ar: 'البت في النزاعات القانونية وإصدار الأحكام بناءً على الأدلة والقانون.', en: 'Deciding legal disputes and issuing rulings based on evidence and law.')),
        SubjectModel(name: BilingualText(ar: 'مستشار قانوني', en: 'Legal Counsel'), description: BilingualText(ar: 'تقديم استشارات قانونية للشركات أو الأفراد لضمان الالتزام بالأنظمة.', en: 'Providing legal advice to companies or individuals to ensure compliance with regulations.')),
        SubjectModel(name: BilingualText(ar: 'مدعٍ عام', en: 'Public Prosecutor'), description: BilingualText(ar: 'تمثيل الدولة في ملاحقة المتهمين في القضايا الجنائية.', en: 'Representing the state in prosecuting defendants in criminal cases.')),
        SubjectModel(name: BilingualText(ar: 'موثق رسمي', en: 'Notary Public'), description: BilingualText(ar: 'توثيق العقود والاتفاقيات القانونية لضمان صحتها رسمياً.', en: 'Documenting contracts and legal agreements to ensure their official validity.')),
        SubjectModel(name: BilingualText(ar: 'أكاديمي قانون', en: 'Law Academic'), description: BilingualText(ar: 'تدريس مواد القانون وإجراء البحوث في النظريات والتشريعات.', en: 'Teaching law subjects and conducting research in theories and legislation.')),
      ],
      workEnvironments: [BilingualText(ar: 'مكاتب المحاماة', en: 'Law Firms'), BilingualText(ar: 'المحاكم', en: 'Courts'), BilingualText(ar: 'شركات ومؤسسات', en: 'Companies & Institutions'), BilingualText(ar: 'الحكومة', en: 'Government')],
      jobAvailability: 'متوسط / Moderate',
      marketSaturation: 'مرتفع / High',
      incomeRange: '500–2000 JOD',
      incomeGrowth: 'متدرج / Gradual',
      incomeStability: 'مستقر بعد التأسيس / Stable After Establishment',
      mastersSpecializations: [BilingualText(ar: 'قانون دولي', en: 'International Law'), BilingualText(ar: 'قانون تجاري', en: 'Commercial Law'), BilingualText(ar: 'قانون حقوق الإنسان', en: 'Human Rights Law'), BilingualText(ar: 'الدراسات القضائية', en: 'Judicial Studies')],
      internationalOpportunities: BilingualText(ar: 'إمكانية العمل في المنظمات الدولية', en: 'Opportunity to work in international organizations'),
      pros: [BilingualText(ar: 'مكانة اجتماعية مرموقة', en: 'High social status'), BilingualText(ar: 'دخل مرتفع بعد التأسيس', en: 'High income after establishment'), BilingualText(ar: 'تنوع المجالات', en: 'Diverse fields'), BilingualText(ar: 'العمل المستقل', en: 'Independent practice')],
      cons: [BilingualText(ar: 'بداية صعبة وبطيئة', en: 'Difficult slow start'), BilingualText(ar: 'تطور مستمر للتشريعات', en: 'Constant legislative changes'), BilingualText(ar: 'ضغط نفسي عالٍ', en: 'High psychological pressure'), BilingualText(ar: 'منافسة شديدة', en: 'Strong competition')],
      notSuitableFor: BilingualText(
        ar: 'الأشخاص الذين لا يفضلون القراءة الكثيفة وتحليل النصوص الطويلة أو من يجدون صعوبة في الجدل المنطقي وبناء الحجج الدفاعية، بالإضافة إلى من لا يمتلك الصبر الكافي للتطور البطيء في بداية المسار المهني القانوني.',
        en: 'People who do not prefer heavy reading and analyzing long texts, or those who find difficulty in logical debate and building defensive arguments, in addition to those who do not have enough patience for the slow progression at the beginning of the legal career path.'
      ),
      suitedPersonality: BilingualText(ar: 'ذكي لبق يتمتع بقدرة الإقناع والتحليل', en: 'Intelligent, articulate, persuasive & analytical'),
      studyIntensity: 'متوسط–مكثف / Moderate–Intensive',
      intensityReason: BilingualText(ar: 'يحتاج للكثير من الحفظ وفهم النصوص القانونية المعقدة.', en: 'Needs a lot of memorization and understanding complex legal texts.'),
      difficultyLevel: 'متوسط / Medium',
      difficultyReason: BilingualText(ar: 'التحدي يكمن في تفسير النصوص وربط القضايا بالقوانين.', en: 'Challenge lies in interpreting texts and linking cases to laws.'),
      timeToIncome: '12–24 شهر / 12–24 Months',
      demandVsReturn: 0.68,
      flexibilityScore: 0.7,
    ),
    'track_humanities': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'علم النفس', en: 'Psychology'), description: BilingualText(ar: 'دراسة العقل البشري والسلوك الفردي والجماعي.', en: 'Studying the human mind and individual/group behavior.')),
        SubjectModel(name: BilingualText(ar: 'علم الاجتماع', en: 'Sociology'), description: BilingualText(ar: 'فهم البنى الاجتماعية والتفاعلات داخل المجتمع.', en: 'Understanding social structures and interactions within society.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'تفكير نقدي', en: 'Critical Thinking'), description: BilingualText(ar: 'القدرة على تحليل الأفكار والنظريات بموضوعية.', en: 'The ability to analyze ideas and theories objectively.')),
        SubjectModel(name: BilingualText(ar: 'ذكاء عاطفي', en: 'Emotional Intelligence'), description: BilingualText(ar: 'فهم مشاعر الآخرين والتفاعل معها بفعالية.', en: 'Understanding others emotions and interacting effectively.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'أخصائي نفسي', en: 'Psychologist'), description: BilingualText(ar: 'تقديم الدعم النفسي والعلاجي للأفراد والمجموعات.', en: 'Providing psychological and therapeutic support to individuals and groups.')),
        SubjectModel(name: BilingualText(ar: 'باحث اجتماعي', en: 'Social Researcher'), description: BilingualText(ar: 'دراسة الظواهر الاجتماعية وتقديم حلول للمشكلات المجتمعية.', en: 'Studying social phenomena and providing solutions for societal problems.')),
        SubjectModel(name: BilingualText(ar: 'مترجم', en: 'Translator'), description: BilingualText(ar: 'نقل المعارف والعلوم بين اللغات والثقافات المختلفة.', en: 'Transferring knowledge and science between different languages and cultures.')),
        SubjectModel(name: BilingualText(ar: 'أخصائي موارد بشرية', en: 'HR Specialist'), description: BilingualText(ar: 'إدارة وتطوير القوى العاملة داخل المؤسسات.', en: 'Managing and developing the workforce within organizations.')),
      ],
      workEnvironments: [BilingualText(ar: 'مراكز استشارية', en: 'Consulting Centers'), BilingualText(ar: 'منظمات دولية', en: 'International Organizations'), BilingualText(ar: 'مدارس وجامعات', en: 'Schools & Universities')],
      jobAvailability: 'متوسط / Moderate',
      marketSaturation: 'مرتفع / High',
      incomeRange: '400–1200 JOD',
      incomeGrowth: 'ثابت / Steady',
      incomeStability: 'مستقر / Stable',
      mastersSpecializations: [BilingualText(ar: 'علم نفس إكلينيكي', en: 'Clinical Psychology'), BilingualText(ar: 'الخدمة الاجتماعية', en: 'Social Work'), BilingualText(ar: 'العلاقات الدولية', en: 'International Relations')],
      internationalOpportunities: BilingualText(ar: 'فرص جيدة في المنظمات الإنسانية والمنظمات غير الحكومية', en: 'Good opportunities in humanitarian organizations and NGOs'),
      pros: [BilingualText(ar: 'فهم عميق للنفس والمجتمع', en: 'Deep self & social understanding'), BilingualText(ar: 'مرونة في العمل', en: 'Work flexibility'), BilingualText(ar: 'مساهمة إنسانية', en: 'Humanitarian contribution')],
      cons: [BilingualText(ar: 'تطلب دراسات عليا للتميز', en: 'Advanced studies needed to excel'), BilingualText(ar: 'رواتب بداية متواضعة', en: 'Modest starting salaries')],
      notSuitableFor: BilingualText(
        ar: 'الأشخاص الذين يفضلون العمل المادي البحت ولا يمتلكون الصبر للتعامل مع القضايا الإنسانية المعقدة أو التفاعل الاجتماعي المستمر مع مختلف فئات المجتمع.',
        en: 'People who prefer purely material work and lack the patience to deal with complex humanitarian issues or constant social interaction with various segments of society.'
      ),
      suitedPersonality: BilingualText(ar: 'متعاطف مثقف يحب القراءة والناس', en: 'Empathetic, cultured, loves reading & people'),
      studyIntensity: 'متوسط / Moderate',
      intensityReason: BilingualText(ar: 'يعتمد بشكل كبير على القراءة الواسعة وكتابة الأبحاث النظرية.', en: 'Relies heavily on extensive reading and writing theoretical research.'),
      difficultyLevel: 'سهل–متوسط / Easy–Medium',
      difficultyReason: BilingualText(ar: 'المفاهيم واضحة لكن التحدي في ربطها بالواقع العملي.', en: 'Concepts are clear but the challenge is linking them to practical reality.'),
      timeToIncome: '6–12 شهر / 6–12 Months',
      demandVsReturn: 0.65,
      flexibilityScore: 0.85,
    ),
    'track_edu': TrackEnrichmentData(
      mainSubjects: [
        SubjectModel(name: BilingualText(ar: 'أصول التربية', en: 'Foundations of Education'), description: BilingualText(ar: 'دراسة النظريات التربوية وتاريخ تطور التعليم.', en: 'Studying educational theories and history of education development.')),
        SubjectModel(name: BilingualText(ar: 'علم النفس التربوي', en: 'Educational Psychology'), description: BilingualText(ar: 'فهم سيكولوجية المتعلم وكيفية تحفيزه للتعلم.', en: 'Understanding the learners psychology and how to motivate them to learn.')),
      ],
      coreSkills: [
        SubjectModel(name: BilingualText(ar: 'إدارة الصف', en: 'Classroom Management'), description: BilingualText(ar: 'القدرة على تنظيم بيئة التعلم وضبط التفاعل داخل الصف.', en: 'The ability to organize the learning environment and control classroom interaction.')),
        SubjectModel(name: BilingualText(ar: 'مهارات العرض', en: 'Presentation Skills'), description: BilingualText(ar: 'تبسيط المعلومات وشرحها بطرق إبداعية ومفهومة.', en: 'Simplifying information and explaining it in creative and understandable ways.')),
      ],
      careerPaths: [
        SubjectModel(name: BilingualText(ar: 'معلم / مدرس', en: 'Teacher'), description: BilingualText(ar: 'نقل المعرفة وتطوير مهارات الطلاب في مختلف التخصصات.', en: 'Transferring knowledge and developing student skills in various subjects.')),
        SubjectModel(name: BilingualText(ar: 'مشرف تربوي', en: 'Educational Supervisor'), description: BilingualText(ar: 'توجيه المعلمين وتقييم المناهج والعملية التعليمية.', en: 'Guiding teachers and evaluating curricula and the educational process.')),
        SubjectModel(name: BilingualText(ar: 'مدير مدرسة', en: 'School Principal'), description: BilingualText(ar: 'إدارة الجوانب الإدارية والتربوية للمنشأة التعليمية.', en: 'Managing administrative and educational aspects of the educational facility.')),
        SubjectModel(name: BilingualText(ar: 'مصمم مناهج', en: 'Curriculum Designer'), description: BilingualText(ar: 'تطوير المواد الدراسية والوسائل التعليمية الحديثة.', en: 'Developing educational materials and modern teaching aids.')),
      ],
      workEnvironments: [BilingualText(ar: 'مدارس حكومية وخاصة', en: 'Public & Private Schools'), BilingualText(ar: 'وزارة التربية والتعليم', en: 'Ministry of Education'), BilingualText(ar: 'مراكز تدريب', en: 'Training Centers')],
      jobAvailability: 'مرتفع / High',
      marketSaturation: 'مرتفع في تخصصات معينة / High in specific subjects',
      incomeRange: '400–1000 JOD',
      incomeGrowth: 'ثابت / Steady',
      incomeStability: 'مستقر جداً / Very Stable',
      mastersSpecializations: [BilingualText(ar: 'تكنولوجيا التعليم', en: 'Educational Technology'), BilingualText(ar: 'إدارة تربوية', en: 'Educational Administration'), BilingualText(ar: 'تربية خاصة', en: 'Special Education')],
      internationalOpportunities: BilingualText(ar: 'فرص جيدة في دول الخليج العربي', en: 'Good opportunities in Arab Gulf countries'),
      pros: [BilingualText(ar: 'مهنة سامية ومؤثرة', en: 'Noble & impactful profession'), BilingualText(ar: 'إجازات سنوية طويلة', en: 'Long annual vacations'), BilingualText(ar: 'استقرار وظيفي', en: 'Job stability')],
      cons: [BilingualText(ar: 'رواتب قد لا تكون كافية في البداية', en: 'Salaries may be insufficient initially'), BilingualText(ar: 'جهد ذهني ونفسي كبير', en: 'Great mental & psychological effort')],
      notSuitableFor: BilingualText(
        ar: 'الأفراد الذين لا يمتلكون الصبر الكافي أو القدرة على التعامل مع الأطفال والمراهقين، أو من لا يجدون المتعة في تكرار الشرح وتطوير طرق إيصال المعلومات.',
        en: 'Individuals who lack enough patience or the ability to deal with children and adolescents, or those who do not find pleasure in repeating explanations and developing ways to deliver information.'
      ),
      suitedPersonality: BilingualText(ar: 'صبور معطاء يحب الأطفال والتعلم', en: 'Patient, giving, loves children & learning'),
      studyIntensity: 'متوسط / Moderate',
      intensityReason: BilingualText(ar: 'يركز على التطبيق العملي والتدريب الميداني في المدارس.', en: 'Focuses on practical application and field training in schools.'),
      difficultyLevel: 'متوسط / Medium',
      difficultyReason: BilingualText(ar: 'التحدي الحقيقي في ممارسة المهنة وليس في دراستها النظرية.', en: 'The real challenge is in practicing the profession, not in its theoretical study.'),
      timeToIncome: '3–6 أشهر / 3–6 Months',
      demandVsReturn: 0.65,
      flexibilityScore: 0.75,
    ),
  };
}
