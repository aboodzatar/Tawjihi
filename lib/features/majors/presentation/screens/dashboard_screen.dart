import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/features/majors/controller/majors_controller.dart';
import '../widgets/major_card.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/persistent_app_bar.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/routes/route_names.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MajorsController.to;
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PersistentAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteNames.aiChat),
        backgroundColor: AppColors.primaryLight,
        child: const Icon(Icons.smart_toy, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.loadMajors(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getResponsivePadding(context),
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroSection(l10n, theme),
              const SizedBox(height: 48),
              _buildRecommendationsSection(context, controller, l10n, theme),
              const SizedBox(height: 48),
              _buildGeneralActions(context, l10n, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroSection(AppLocalizations l10n, ThemeData theme) {
    return Center(
      child: Column(
        children: [
          Text(
            l10n.dashboard_intro_title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              l10n.dashboard_intro_desc,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection(
    BuildContext context, 
    MajorsController controller, 
    AppLocalizations l10n, 
    ThemeData theme
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recommended_for_you,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: () => Get.toNamed(RouteNames.allMajors),
              icon: const Icon(Icons.arrow_forward_ios, size: 14),
              label: Text(l10n.see_all),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isLoading.value) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          
          // Show top 5 or 3 majors
          final topMajors = controller.majorsList.take(5).toList();

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: topMajors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final major = topMajors[index];
                return SizedBox(
                  width: 300,
                  child: MajorCard(
                    major: major,
                    onTap: () => Get.toNamed(
                      RouteNames.majorDetails,
                      arguments: major.id,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGeneralActions(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.quiz_outlined,
            title: l10n.nav_quiz,
            color: Colors.orange,
            onTap: () => Get.toNamed(RouteNames.qGlobal),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.list_alt_outlined,
            title: l10n.nav_majors,
            color: AppColors.secondary,
            onTap: () => Get.toNamed(RouteNames.allMajors),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, 
    {required IconData icon, required String title, required Color color, required VoidCallback onTap}
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
