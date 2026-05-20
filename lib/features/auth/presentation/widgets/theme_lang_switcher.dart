import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tawjihi_new/features/auth/controller/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeLangSwitcher extends StatelessWidget {
  const ThemeLangSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.to;
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          final isDark = controller.isDarkMode.value;
          final color = isDark ? Colors.white : Colors.black87;
          
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: color),
                tooltip: isDark ? l10n.theme_light : l10n.theme_dark,
                onPressed: controller.toggleTheme,
              ),
              const SizedBox(width: 4),
              TextButton(
                onPressed: controller.toggleLanguage,
                child: Text(
                  controller.currentLocale.value == 'ar' ? 'English' : 'عربي',
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
