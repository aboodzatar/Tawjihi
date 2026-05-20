import 'package:get/get.dart';
import 'package:tawjihi_new/features/guidance/presentation/screens/uni_advice_screen.dart';
import 'route_names.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/majors/presentation/screens/dashboard_screen.dart';
import '../../features/majors/presentation/screens/all_majors_screen.dart';
import '../../features/majors/presentation/screens/major_details_screen.dart';
import '../../features/majors/binding/majors_binding.dart';
import '../../features/questionnaire/presentation/screens/global_questions_screen.dart';
import '../../features/questionnaire/presentation/screens/suggested_majors_screen.dart';
import '../../features/questionnaire/binding/questionnaire_binding.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/controller/profile_controller.dart';
import '../../features/onboarding/presentation/screens/preferences_screen.dart';
import '../../features/onboarding/controller/onboarding_controller.dart';
import '../../features/ai_assistant/presentation/screens/ai_chat_screen.dart';


class AppRoutes {
  static final routes = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RouteNames.preferences,
      page: () => const PreferencesScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OnboardingController())),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.dashboard,
      page: () => const DashboardScreen(),
      binding: MajorsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.allMajors,
      page: () => const AllMajorsScreen(),
      binding: MajorsBinding(),
    ),
    
    // Unified Questionnaire
    GetPage(
      name: RouteNames.qGlobal,
      page: () => const GlobalQuestionsScreen(),
      binding: QuestionnaireBinding(),
    ),
    GetPage(
      name: RouteNames.qSuggestedMajors,
      page: () => const SuggestedMajorsScreen(),
      binding: QuestionnaireBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: RouteNames.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ProfileController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteNames.majorDetails,
      page: () => const MajorDetailsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteNames.aiChat,
      page: () => const AIChatScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: RouteNames.uniAdvice,
      page: () => const UniAdviceScreen(),
      transition: Transition.cupertino,
    ),
  ];
}
