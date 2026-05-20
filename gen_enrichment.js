const fs = require('fs');
const B = (ar, en) => `BilingualText(ar: '${ar}', en: '${en}')`;
const BL = (pairs) => `[${pairs.map(p => B(p[0], p[1])).join(', ')}]`;

function track(id, d) {
  return `'${id}': TrackEnrichmentData(
    mainSubjects: ${BL(d.subj)},
    coreSkills: ${BL(d.skills)},
    careerPaths: ${BL(d.careers)},
    workEnvironments: ${BL(d.envs)},
    jobAvailability: '${d.job}',
    marketSaturation: '${d.sat}',
    incomeRange: '${d.income}',
    incomeGrowth: '${d.growth}',
    incomeStability: '${d.stab}',
    mastersSpecializations: ${BL(d.masters)},
    internationalOpportunities: ${B(d.intl[0], d.intl[1])},
    pros: ${BL(d.pros)},
    cons: ${BL(d.cons)},
    notSuitableFor: ${B(d.nsf[0], d.nsf[1])},
    suitedPersonality: ${B(d.pers[0], d.pers[1])},
    studyIntensity: '${d.intensity}',
    difficultyLevel: '${d.diff}',
    timeToIncome: '${d.tti}',
    demandVsReturn: ${d.dvr},
    flexibilityScore: ${d.flex},
  )`;
}

const tracks = [
  track('track_eng', {
    subj: [['رياضيات هندسية','Engineering Math'],['فيزياء','Physics'],['ميكانيكا','Mechanics'],['برمجة','Programming'],['مواد هندسية','Materials Science'],['ترموديناميكا','Thermodynamics']],
    skills: [['حل المشكلات','Problem Solving'],['تفكير تحليلي','Analytical Thinking'],['برمجة','Coding'],['إدارة مشاريع','Project Management'],['عمل جماعي','Teamwork'],['تصميم هندسي','Engineering Design']],
    careers: [['مهندس مدني','Civil Engineer'],['مهندس كهربائي','Electrical Engineer'],['مهندس ميكانيكي','Mechanical Engineer'],['مهندس برمجيات','Software Engineer'],['مستشار هندسي','Engineering Consultant'],['مدير مشاريع','Project Manager']],
    envs: [['مكتب هندسي','Engineering Office'],['موقع بناء','Construction Site'],['مصنع','Factory'],['قطاع حكومي','Government Sector']],
    job: 'مرتفع / High', sat: 'متوسط / Moderate',
    income: '700–1800 JOD', growth: 'تصاعدي / Rising', stab: 'مستقر / Stable',
    masters: [['هندسة إنشائية','Structural Engineering'],['هندسة بيئية','Environmental Engineering'],['إدارة المشاريع','Project Management'],['هندسة الحاسوب','Computer Engineering']],
    intl: ['فرص ممتازة في الخليج وأوروبا وكندا','Excellent opportunities in Gulf, Europe & Canada'],
    pros: [['رواتب مرتفعة','High salaries'],['طلب متزايد','Growing demand'],['تنوع التخصصات','Wide specializations'],['احترام اجتماعي','Social prestige'],['مشاريع مؤثرة','Impactful projects']],
    cons: [['ساعات دراسة طويلة','Long study hours'],['ضغط عالٍ','High pressure'],['متطلبات رياضية قوية','Strong math required']],
    nsf: ['من يكره الرياضيات والعلوم','Those who dislike math & sciences'],
    pers: ['تحليلي منطقي يحب حل المشكلات','Analytical, logical, problem-solver'],
    intensity: 'مكثف / Intensive', diff: 'صعب / Hard', tti: '6 أشهر / 6 Months', dvr: 0.87, flex: 0.72,
  }),
  track('track_it', {
    subj: [['أساسيات البرمجة','Programming Fundamentals'],['قواعد البيانات','Databases'],['شبكات الحاسوب','Computer Networks'],['هندسة البرمجيات','Software Engineering'],['أمن المعلومات','Cybersecurity'],['ذكاء اصطناعي','Artificial Intelligence']],
    skills: [['برمجة','Programming'],['تحليل البيانات','Data Analysis'],['حل مشاكل تقنية','Technical Problem Solving'],['أمن معلومات','Information Security'],['تفكير خوارزمي','Algorithmic Thinking'],['إدارة مشاريع تقنية','Technical Project Management']],
    careers: [['مطور برمجيات','Software Developer'],['مهندس شبكات','Network Engineer'],['محلل بيانات','Data Analyst'],['متخصص أمن معلومات','Security Specialist'],['مطور تطبيقات','App Developer'],['مهندس ذكاء اصطناعي','AI Engineer']],
    envs: [['شركات تقنية','Tech Companies'],['عمل عن بعد','Remote Work'],['شركات ناشئة','Startups'],['قطاع حكومي','Government IT']],
    job: 'مرتفع جداً / Very High', sat: 'مرتفع / High',
    income: '600–2000 JOD', growth: 'تصاعدي سريع / Fast Rising', stab: 'مستقر / Stable',
    masters: [['أمن المعلومات','Cybersecurity'],['الذكاء الاصطناعي','Artificial Intelligence'],['علم البيانات','Data Science'],['هندسة البرمجيات','Software Engineering']],
    intl: ['فرص عالمية واسعة وإمكانية العمل عن بعد','Global opportunities with remote work flexibility'],
    pros: [['طلب عالمي ضخم','Massive global demand'],['رواتب تنافسية','Competitive salaries'],['إمكانية العمل الحر','Freelancing potential'],['تطور مستمر','Continuous growth'],['مرونة مكان العمل','Workplace flexibility']],
    cons: [['تطور سريع يتطلب تعلماً مستمراً','Fast changes require constant learning'],['ضغط مواعيد التسليم','Deadline pressure'],['منافسة عالية','High competition']],
    nsf: ['من لا يحب المنطق والتفكير التقني','Those who dislike logical & technical thinking'],
    pers: ['فضولي يحب التقنية ويستمتع ببناء الأنظمة','Curious, tech-passionate, enjoys building systems'],
    intensity: 'مكثف / Intensive', diff: 'متوسط–صعب / Medium–Hard', tti: '3 أشهر / 3 Months', dvr: 0.91, flex: 0.88,
  }),
  track('track_business', {
    subj: [['مبادئ المحاسبة','Accounting Principles'],['اقتصاد كلي وجزئي','Macro & Micro Economics'],['إدارة الأعمال','Business Management'],['تسويق','Marketing'],['مالية','Finance'],['إحصاء','Statistics']],
    skills: [['تحليل مالي','Financial Analysis'],['تفكير استراتيجي','Strategic Thinking'],['مهارات تواصل','Communication Skills'],['قيادة','Leadership'],['إدارة الوقت','Time Management'],['مفاوضة','Negotiation']],
    careers: [['محاسب','Accountant'],['مدير مالي','Financial Manager'],['مسوّق','Marketer'],['محلل أعمال','Business Analyst'],['مدير موارد بشرية','HR Manager'],['مستشار إداري','Management Consultant']],
    envs: [['مكاتب الشركات','Corporate Offices'],['بنوك','Banks'],['شركات ناشئة','Startups'],['مؤسسات حكومية','Government Institutions']],
    job: 'متوسط–مرتفع / Medium–High', sat: 'مرتفع / High',
    income: '500–1400 JOD', growth: 'ثابت مع نمو / Steady with Growth', stab: 'مستقر / Stable',
    masters: [['ماجستير إدارة الأعمال MBA','MBA'],['مالية','Finance'],['تسويق رقمي','Digital Marketing'],['ريادة الأعمال','Entrepreneurship']],
    intl: ['فرص في الخليج والأسواق الدولية','Opportunities in Gulf & international markets'],
    pros: [['تنوع مسارات العمل','Diverse career paths'],['مهارات قابلة للتحويل','Transferable skills'],['إمكانية ريادة الأعمال','Entrepreneurship opportunity'],['طلب ثابت','Consistent demand']],
    cons: [['سوق مشبع بالخريجين','Saturated graduate market'],['منافسة عالية','High competition'],['قد تبدأ الرواتب منخفضة','Salaries may start low']],
    nsf: ['من يريد عملاً تقنياً أو علمياً بحتاً','Those seeking purely technical or scientific work'],
    pers: ['شخص اجتماعي طموح يحب الأرقام والناس','Social, ambitious, enjoys numbers & people'],
    intensity: 'متوسط / Moderate', diff: 'متوسط / Medium', tti: '3–6 أشهر / 3–6 Months', dvr: 0.74, flex: 0.82,
  }),
  track('track_science', {
    subj: [['كيمياء عامة','General Chemistry'],['أحياء','Biology'],['فيزياء','Physics'],['رياضيات','Mathematics'],['إحصاء','Statistics'],['بيوكيمياء','Biochemistry']],
    skills: [['تفكير نقدي','Critical Thinking'],['بحث علمي','Scientific Research'],['تحليل مختبري','Lab Analysis'],['كتابة علمية','Scientific Writing'],['حل المشكلات','Problem Solving']],
    careers: [['باحث علمي','Research Scientist'],['كيميائي','Chemist'],['بيولوجي','Biologist'],['فيزيائي','Physicist'],['محلل مختبري','Lab Analyst'],['أكاديمي','Academic']],
    envs: [['مختبرات بحثية','Research Labs'],['جامعات','Universities'],['شركات أدوية','Pharmaceutical Companies'],['مؤسسات حكومية','Government Agencies']],
    job: 'متوسط / Moderate', sat: 'متوسط / Moderate',
    income: '450–1200 JOD', growth: 'ثابت / Steady', stab: 'متوسط / Moderate',
    masters: [['كيمياء تحليلية','Analytical Chemistry'],['علم الأحياء الجزيئي','Molecular Biology'],['فيزياء تطبيقية','Applied Physics'],['دكتوراه بحث','Research PhD']],
    intl: ['فرص بحثية دولية وبرامج تبادل جامعي','International research & university exchange programs'],
    pros: [['عمل فكري ممتع','Intellectually rewarding work'],['مساهمة في العلم','Contributing to science'],['إمكانية التدريس','Teaching possibility'],['أكاديميات وأبحاث','Academia & research']],
    cons: [['رواتب بداية متدنية','Low starting salaries'],['فرص عمل محدودة محلياً','Limited local jobs'],['يتطلب دراسات عليا للتقدم','Advanced degrees needed to advance']],
    nsf: ['من يريد عائداً مالياً سريعاً','Those seeking quick financial returns'],
    pers: ['فضولي يحب الاستكشاف والبحث والتجريب','Curious, loves exploration, research & experimentation'],
    intensity: 'مكثف / Intensive', diff: 'صعب / Hard', tti: '12+ أشهر / 12+ Months', dvr: 0.61, flex: 0.65,
  }),
  track('track_health', {
    subj: [['تشريح','Anatomy'],['فسيولوجيا','Physiology'],['علم الأدوية','Pharmacology'],['الأحياء الدقيقة','Microbiology'],['كيمياء حيوية','Biochemistry'],['علم الأمراض','Pathology']],
    skills: [['مهارات تشخيصية','Diagnostic Skills'],['تواصل مع المرضى','Patient Communication'],['دقة وانتباه','Precision & Attention'],['قدرة على ضغط العمل','Work Under Pressure'],['عمل جماعي','Teamwork'],['اتخاذ قرار سريع','Quick Decision Making']],
    careers: [['طبيب','Physician'],['صيدلاني','Pharmacist'],['ممرض','Nurse'],['أخصائي مختبرات','Lab Specialist'],['فيزيائي طبي','Medical Physicist'],['مدير مستشفى','Hospital Administrator']],
    envs: [['مستشفيات','Hospitals'],['عيادات','Clinics'],['مختبرات','Laboratories'],['صيدليات','Pharmacies']],
    job: 'مرتفع جداً / Very High', sat: 'متوسط / Moderate',
    income: '800–4000 JOD', growth: 'مستقر ومتصاعد / Stable & Rising', stab: 'عالٍ جداً / Very High',
    masters: [['تخصصات طبية','Medical Specializations'],['صحة عامة','Public Health'],['إدارة صحية','Health Management'],['طب طوارئ','Emergency Medicine']],
    intl: ['فرص واسعة في الخليج وأوروبا وكندا','Wide opportunities in Gulf, Europe & Canada'],
    pros: [['وظيفة نبيلة ومؤثرة','Noble & impactful career'],['رواتب عالية جداً','Very high salaries'],['استقرار وظيفي دائم','Permanent job stability'],['احترام اجتماعي كبير','High social prestige']],
    cons: [['سنوات دراسة طويلة جداً','Very long study years'],['ضغط عمل شديد','Intense work pressure'],['مسؤولية أخلاقية عالية','High ethical responsibility'],['وقت فراغ محدود','Limited leisure time']],
    nsf: ['من لا يتحمل الضغط والمسؤولية الكبيرة','Those unable to handle high pressure & responsibility'],
    pers: ['متعاطف صبور يتحمل الضغط ويرغب بمساعدة الآخرين','Empathetic, patient, handles pressure & wants to help others'],
    intensity: 'مكثف جداً / Very Intensive', diff: 'صعب جداً / Very Hard', tti: '12–24 شهر / 12–24 Months', dvr: 0.93, flex: 0.55,
  }),
  track('track_law', {
    subj: [['مبادئ القانون','Principles of Law'],['قانون مدني','Civil Law'],['قانون جزائي','Criminal Law'],['قانون دستوري','Constitutional Law'],['قانون تجاري','Commercial Law'],['إجراءات قضائية','Judicial Procedures']],
    skills: [['تحليل قانوني','Legal Analysis'],['خطابة وإقناع','Oratory & Persuasion'],['كتابة قانونية','Legal Writing'],['بحث وتوثيق','Research & Documentation'],['تفاوض','Negotiation'],['تفكير نقدي','Critical Thinking']],
    careers: [['محامي','Lawyer'],['قاضي','Judge'],['مستشار قانوني','Legal Counsel'],['مدعٍ عام','Public Prosecutor'],['موثق رسمي','Notary Public'],['أكاديمي قانون','Law Academic']],
    envs: [['مكاتب المحاماة','Law Firms'],['المحاكم','Courts'],['شركات ومؤسسات','Companies & Institutions'],['الحكومة','Government']],
    job: 'متوسط / Moderate', sat: 'مرتفع / High',
    income: '500–2000 JOD', growth: 'متدرج / Gradual', stab: 'مستقر بعد التأسيس / Stable After Establishment',
    masters: [['قانون دولي','International Law'],['قانون تجاري','Commercial Law'],['قانون حقوق الإنسان','Human Rights Law'],['الدراسات القضائية','Judicial Studies']],
    intl: ['إمكانية العمل في المنظمات الدولية','Opportunity to work in international organizations'],
    pros: [['مكانة اجتماعية مرموقة','High social status'],['دخل مرتفع بعد التأسيس','High income after establishment'],['تنوع المجالات','Diverse fields'],['العمل المستقل','Independent practice']],
    cons: [['بداية صعبة وبطيئة','Difficult slow start'],['تطور مستمر للتشريعات','Constant legislative changes'],['ضغط نفسي عالٍ','High psychological pressure'],['منافسة شديدة','Strong competition']],
    nsf: ['من لا يميل للجدل والحجج المنطقية','Those who dislike arguments & logical debates'],
    pers: ['ذكي لبق يتمتع بقدرة الإقناع والتحليل','Intelligent, articulate, persuasive & analytical'],
    intensity: 'متوسط–مكثف / Moderate–Intensive', diff: 'متوسط / Medium', tti: '12–24 شهر / 12–24 Months', dvr: 0.68, flex: 0.70,
  }),
  track('track_edu', {
    subj: [['علم النفس التربوي','Educational Psychology'],['مناهج وطرق تدريس','Curriculum & Teaching Methods'],['قياس وتقييم','Measurement & Assessment'],['إدارة الصف','Classroom Management'],['تقنيات تعليمية','Educational Technology'],['علم الاجتماع التربوي','Educational Sociology']],
    skills: [['التواصل الفعال','Effective Communication'],['الصبر','Patience'],['التخطيط للدروس','Lesson Planning'],['إدارة الوقت','Time Management'],['الإبداع','Creativity'],['تحفيز الطلاب','Student Motivation']],
    careers: [['معلم','Teacher'],['مشرف تربوي','Educational Supervisor'],['مرشد طلابي','Student Counselor'],['مدير مدرسة','School Principal'],['مطور مناهج','Curriculum Developer'],['أكاديمي','Academic']],
    envs: [['مدارس حكومية','Public Schools'],['مدارس خاصة','Private Schools'],['جامعات','Universities'],['مراكز تدريب','Training Centers']],
    job: 'مرتفع / High', sat: 'مرتفع / High',
    income: '400–900 JOD', growth: 'ثابت / Steady', stab: 'عالٍ / High',
    masters: [['الإدارة التربوية','Educational Administration'],['الإرشاد النفسي','Psychological Counseling'],['التعليم الإلكتروني','E-Learning'],['تصميم المناهج','Curriculum Design']],
    intl: ['فرص في المدارس الدولية والمنظمات التعليمية','Opportunities in international schools & educational organizations'],
    pros: [['استقرار وظيفي','Job stability'],['إجازات طويلة','Long vacations'],['تأثير إيجابي في المجتمع','Positive community impact'],['وظيفة ذات معنى','Meaningful career']],
    cons: [['رواتب متدنية نسبياً','Relatively low salaries'],['تحديات سلوكية مع الطلاب','Behavioral challenges with students'],['ضغط إداري','Administrative pressure']],
    nsf: ['من لا يحب التعامل مع الأطفال والتعليم','Those who dislike working with children & teaching'],
    pers: ['صبور متحمس ومبدع يحب التأثير في الآخرين','Patient, enthusiastic, creative & loves impacting others'],
    intensity: 'متوسط / Moderate', diff: 'متوسط / Medium', tti: '3–6 أشهر / 3–6 Months', dvr: 0.66, flex: 0.75,
  }),
  track('track_humanities', {
    subj: [['تاريخ','History'],['جغرافيا','Geography'],['فلسفة','Philosophy'],['علم الاجتماع','Sociology'],['لغة عربية','Arabic Language'],['لغة إنجليزية','English Language']],
    skills: [['تحليل نصوص','Text Analysis'],['كتابة إبداعية','Creative Writing'],['تفكير نقدي','Critical Thinking'],['بحث وتوثيق','Research & Documentation'],['تواصل','Communication'],['الترجمة','Translation']],
    careers: [['صحفي','Journalist'],['مترجم','Translator'],['كاتب','Writer'],['أخصائي علاقات عامة','PR Specialist'],['مرشد سياحي','Tour Guide'],['باحث اجتماعي','Social Researcher']],
    envs: [['وسائل إعلام','Media Outlets'],['مؤسسات ثقافية','Cultural Institutions'],['جامعات ومدارس','Universities & Schools'],['منظمات دولية','International Organizations']],
    job: 'متوسط / Moderate', sat: 'مرتفع / High',
    income: '350–900 JOD', growth: 'بطيء / Slow', stab: 'متذبذب / Variable',
    masters: [['دراسات ثقافية','Cultural Studies'],['ترجمة وتعريب','Translation & Arabization'],['إعلام وصحافة','Media & Journalism'],['علم النفس','Psychology']],
    intl: ['فرص في المنظمات الدولية والسفارات','Opportunities in international organizations & embassies'],
    pros: [['تنوع المسارات الوظيفية','Diverse career paths'],['إبداع وتعبير ذاتي','Creativity & self-expression'],['فهم المجتمع والإنسان','Understanding society & humanity'],['مرونة في العمل','Work flexibility']],
    cons: [['رواتب منخفضة غالباً','Generally low salaries'],['سوق عمل محدود','Limited job market'],['صعوبة التوظيف المباشر','Difficult direct employment']],
    nsf: ['من يبحث عن رواتب مرتفعة وعمل تقني','Those seeking high salaries & technical work'],
    pers: ['مبدع حساس يحب الأدب والثقافة والتعبير','Creative, sensitive, loves literature, culture & expression'],
    intensity: 'متوسط / Moderate', diff: 'سهل–متوسط / Easy–Medium', tti: '6–12 شهر / 6–12 Months', dvr: 0.52, flex: 0.78,
  }),
];

const header = `import '../models/bilingual_text.dart';

class TrackEnrichmentData {
  final List<BilingualText> mainSubjects;
  final List<BilingualText> coreSkills;
  final List<BilingualText> careerPaths;
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
  final String difficultyLevel;
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
    required this.difficultyLevel,
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
`;

const footer = `  };
}
`;

fs.writeFileSync('lib/data/mock/track_enrichment_data.dart', header + tracks.join(',\n') + ',\n' + footer);
console.log('Done! File written.');
