import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/constants.dart';
import '../routes/route_names.dart';
import '../../features/auth/controller/auth_controller.dart';

class PersistentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final bool showHomeOption;
  final VoidCallback? onRetakeSurvey;
  final PreferredSizeWidget? bottom;

  const PersistentAppBar({
    super.key, 
    this.title, 
    this.showLogo = true,
    this.showHomeOption = false,
    this.onRetakeSurvey,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = AuthController.to;
    
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[
            const Icon(Icons.navigation, color: AppColors.primaryLight),
            const SizedBox(width: 8),
          ],
          Text(
            title ?? l10n.app_name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        Obx(() {
          final isDark = controller.isDarkMode.value;
          final locale = controller.currentLocale.value;

          return PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              if (value == 'theme') controller.toggleTheme();
              if (value == 'lang') controller.toggleLanguage();
              if (value == 'home') Get.offAllNamed(RouteNames.dashboard);
              if (value == 'retake') onRetakeSurvey?.call();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode, 
                      size: 20,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    const SizedBox(width: 12),
                    Text(isDark ? l10n.theme_light : l10n.theme_dark),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'lang',
                child: Row(
                  children: [
                    Icon(
                      Icons.language, 
                      size: 20,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    const SizedBox(width: 12),
                    Text(locale == 'ar' ? 'English' : 'عربي'),
                  ],
                ),
              ),
              if (showHomeOption)
                PopupMenuItem(
                  value: 'home',
                  child: Row(
                    children: [
                      Icon(
                        Icons.home_outlined, 
                        size: 20,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(width: 12),
                      Text(l10n.localeName == 'ar' ? 'الصفحة الرئيسية' : 'Home'),
                    ],
                  ),
                ),
              if (onRetakeSurvey != null)
                PopupMenuItem(
                  value: 'retake',
                  child: Row(
                    children: [
                      Icon(
                        Icons.refresh, 
                        size: 20,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(width: 12),
                      Text(l10n.retake_questionnaire),
                    ],
                  ),
                ),
            ],
          );
        }),
      ],
      elevation: 0,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    double height = kToolbarHeight;
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }
}
