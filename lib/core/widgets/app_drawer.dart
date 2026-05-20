import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/core/localization/locale_helper.dart';
import '../utils/constants.dart';
import '../routes/route_names.dart';
import '../../features/auth/controller/auth_controller.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authController = AuthController.to;
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          _buildHeader(context, authController, l10n),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(
                  icon: Icons.dashboard_outlined,
                  title: l10n.nav_home,
                  route: RouteNames.dashboard,
                  context: context,
                ),
                _buildNavItem(
                  icon: Icons.list_alt_outlined,
                  title: l10n.nav_majors,
                  route: RouteNames.allMajors,
                  context: context,
                ),
                _buildNavItem(
                  icon: Icons.quiz_outlined,
                  title: l10n.nav_quiz,
                  route: RouteNames.qGlobal,
                  context: context,
                ),
                _buildNavItem(
                  icon: Icons.smart_toy_outlined,
                  title: l10n.nav_ai ?? "AI Assistance",
                  route: RouteNames.aiChat,
                  context: context,
                ),
                _buildNavItem(
                  icon: Icons.lightbulb_outline,
                  title: l10n.nav_guidance ?? "Uni Guidance",
                  route: RouteNames.uniAdvice,
                  context: context,
                ),
                _buildNavItem(
                  icon: Icons.person_outline,
                  title: l10n.nav_profile,
                  route: RouteNames.profile,
                  context: context,
                ),
              ],
            ),
          ),
          const Divider(),
          _buildProfileFooter(authController, l10n, theme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AuthController auth, AppLocalizations l10n) {
    return DrawerHeader(
      decoration: BoxDecoration(color: AppColors.primaryLight.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.navigation, color: AppColors.primaryLight, size: 32),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      auth.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
                      size: 20,
                    ),
                    onPressed: () => auth.toggleTheme(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.language, size: 20),
                    onPressed: () => auth.toggleLanguage(),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            l10n.app_name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required String route,
    required BuildContext context,
  }) {
    final isSelected = Get.currentRoute == route;
    return ListTile(
      leading: Icon(icon, color: isSelected ? AppColors.primaryLight : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryLight : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      onTap: () {
        Get.back(); // Close drawer
        if (!isSelected) {
          Get.toNamed(route);
        }
      },
      selected: isSelected,
    );
  }

  Widget _buildProfileFooter(AuthController auth, AppLocalizations l10n, ThemeData theme) {
    final student = auth.currentStudent.value;
    if (student == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.back();
              Get.toNamed(RouteNames.profile);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.fullName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${student.tawjihiPercentage}% - ${LocaleHelper.getLabel(Get.context!, student.track)}",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.logout, size: 18),
            label: Text(l10n.logout),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
