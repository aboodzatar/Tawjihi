import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/features/profile/controller/profile_controller.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/localization/locale_helper.dart';
import '../../../../core/widgets/persistent_app_bar.dart';
import '../../../../core/widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: PersistentAppBar(title: l10n.nav_profile, showLogo: false),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getResponsivePadding(context),
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, controller, l10n, theme),
              const SizedBox(height: 32),
              _buildAcademicCard(context, controller, l10n, theme),
              const SizedBox(height: 24),
              _buildPreferencesCard(context, controller, l10n, theme),
              const SizedBox(height: 40),
              _buildSaveButton(controller, l10n),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ProfileController controller,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.primaryLight,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.fullName.value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${l10n.student_id}: ${controller.studentId.value}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAcademicCard(
    BuildContext context,
    ProfileController controller,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.school_outlined,
                  color: AppColors.primaryLight,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.academic_info,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 32),
            _buildInfoRow(
              l10n.tawjihi_score,
              "${controller.percentage.value}%",
              theme,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              l10n.academic_track,
              LocaleHelper.getLabel(context, controller.track.value),
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesCard(
    BuildContext context,
    ProfileController controller,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings_outlined, color: AppColors.secondary),
                const SizedBox(width: 8),
                Text(
                  l10n.personal_preferences,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 32),

            // Governorate
            Text(l10n.governorate_label, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.governorate.value,
                  isExpanded: true,
                  items:
                      AppConstants.governorateKeys.map((key) {
                        return DropdownMenuItem(
                          value: key,
                          child: Text(LocaleHelper.getLabel(context, key)),
                        );
                      }).toList(),
                  onChanged: (val) => controller.governorate.value = val!,
                ),
              ),
            ),

            const SizedBox(height: 24),
            SwitchListTile(
              title: Text(
                l10n.can_travel,
                style: const TextStyle(fontSize: 14),
              ),
              value: controller.canTravel.value,
              onChanged: (val) => controller.canTravel.value = val,
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.primaryLight,
            ),

            const SizedBox(height: 24),
            Text(l10n.program_types_label, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children:
                  AppConstants.programTypeKeys.map((key) {
                    final isSelected = controller.selectedProgramTypes.contains(
                      key,
                    );
                    return FilterChip(
                      label: Text(LocaleHelper.getLabel(context, key)),
                      selected: isSelected,
                      onSelected: (_) => controller.toggleProgramType(key),
                      selectedColor: AppColors.primaryLight.withOpacity(0.2),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 24),
            Text(l10n.admission_types_label, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children:
                  AppConstants.admissionTypeKeys.map((key) {
                    final isSelected = controller.selectedAdmissionTypes
                        .contains(key);
                    return FilterChip(
                      label: Text(LocaleHelper.getLabel(context, key)),
                      selected: isSelected,
                      onSelected: (_) => controller.toggleAdmissionType(key),
                      selectedColor: AppColors.secondary.withOpacity(0.2),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSaveButton(ProfileController controller, AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: () {
        controller.saveProfile();
        Get.snackbar(
          l10n.success ?? "Success",
          l10n.profile_updated ?? "Profile updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        l10n.save_changes,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
