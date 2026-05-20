import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';
import 'core/theme/app_themes.dart';
import 'core/utils/shared_prefs_helper.dart';
import 'features/auth/controller/auth_controller.dart';

import 'data/services/local_data_service.dart';
import 'features/majors/controller/majors_controller.dart';
import 'features/profile/controller/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize persistence layer
  await SharedPrefsHelper.init();
  
  // Initialize Local Data Service (Offline mode)
  await Get.putAsync(() => LocalDataService().init());
  
  // Initialize AuthController (handles theme/locale state)
  Get.put(AuthController());
  
  // Register core feature controllers globally
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => MajorsController());
  
  runApp(const DalilakApp());
}

class DalilakApp extends StatelessWidget {
  const DalilakApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = AuthController.to;

    return Obx(() => GetMaterialApp(
      title: 'دليلك (Dalilak)',
      debugShowCheckedModeBanner: false,
      
      // Theme settings
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: authController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      
      // Localization settings
      locale: Locale(authController.currentLocale.value),
      fallbackLocale: const Locale('ar'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      
      // Routing
      initialRoute: RouteNames.splash,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      
      // Responsive builder logic if needed, but GetMaterialApp handles basic responsiveness
      // and we used ConstrainedBox/LayoutBuilder in screens.
    ));
  }
}
