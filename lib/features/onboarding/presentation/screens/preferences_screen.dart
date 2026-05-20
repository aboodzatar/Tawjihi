import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/localization/locale_helper.dart';
import '../../controller/onboarding_controller.dart';

import '../../../../core/widgets/persistent_app_bar.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PersistentAppBar(
        title: l10n.preferences_title,
        showLogo: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getResponsivePadding(context),
            vertical: 24,
          ),
          children: [
            Text(
              l10n.preferences_desc,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Governorate Dropdown
            _buildSectionTitle(l10n.governorate_label, theme),
            const SizedBox(height: 12),
            _buildGovernorateDropdown(context, controller),

            const SizedBox(height: 24),
            Obx(
              () => SwitchListTile(
                title: Text(
                  l10n.open_to_other_gov,
                  style: const TextStyle(fontSize: 14),
                ),
                value: controller.openToOtherGovernorate.value,
                onChanged:
                    (val) => controller.openToOtherGovernorate.value = val,
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primaryLight,
              ),
            ),

            const Divider(height: 48),

            // Program Types
            _buildSectionTitle(l10n.program_types_label, theme),
            const SizedBox(height: 12),
            _buildProgramTypes(context, controller),

            const Divider(height: 48),

            // Admission Channels
            _buildSectionTitle(l10n.admission_types_label, theme),
            const SizedBox(height: 12),
            _buildAdmissionChannels(context, controller),

            const Divider(height: 48),

            // Test or Home
            _buildSectionTitle(
              l10n.localeName == 'ar'
                  ? 'هل تريد إجراء اختبار الاهتمامات؟'
                  : 'Do you want to take an interest test?',
              theme,
            ),
            const SizedBox(height: 4),
            Text(
              l10n.localeName == 'ar'
                  ? 'سيساعدك الاختبار في اكتشاف التخصصات الأنسب لك بناءً على اهتماماتك'
                  : 'The test helps match you with majors based on your interests and personality',
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Obx(() => Column(
              children: [
                _buildRadioOption(
                  context,
                  value: true,
                  groupValue: controller.wantsTest.value,
                  label: l10n.localeName == 'ar'
                      ? '✅ نعم، أريد إجراء الاختبار'
                      : '✅ Yes, take the interest test',
                  onChanged: (v) => controller.wantsTest.value = v!,
                ),
                const SizedBox(height: 8),
                _buildRadioOption(
                  context,
                  value: false,
                  groupValue: controller.wantsTest.value,
                  label: l10n.localeName == 'ar'
                      ? '🏠 لا، انتقل إلى الصفحة الرئيسية مباشرةً'
                      : '🏠 No, go to home screen directly',
                  onChanged: (v) => controller.wantsTest.value = v!,
                ),
              ],
            )),

            const SizedBox(height: 48),

            ElevatedButton(
              onPressed: () => controller.saveAndContinue(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: AppColors.primaryLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                ),
              ),
              child: Text(
                l10n.next,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildGovernorateDropdown(
    BuildContext context,
    OnboardingController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedGovernorate.value,
            isExpanded: true,
            items:
                AppConstants.governorateKeys.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(LocaleHelper.getLabel(context, key)),
                  );
                }).toList(),
            onChanged: (val) => controller.selectedGovernorate.value = val!,
          ),
        ),
      ),
    );
  }

  Widget _buildProgramTypes(
    BuildContext context,
    OnboardingController controller,
  ) {
    return Obx(
      () => Wrap(
        spacing: 8,
        children:
            AppConstants.programTypeKeys.map((key) {
              final isSelected = controller.selectedProgramTypes.contains(key);
              return FilterChip(
                label: Text(LocaleHelper.getLabel(context, key)),
                selected: isSelected,
                onSelected: (_) => controller.toggleProgramType(key),
                selectedColor: AppColors.primaryLight.withOpacity(0.2),
                checkmarkColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildAdmissionChannels(
    BuildContext context,
    OnboardingController controller,
  ) {
    return Obx(
      () => Wrap(
        spacing: 8,
        children:
            AppConstants.admissionTypeKeys.map((key) {
              final isSelected = controller.selectedAdmissionTypes.contains(
                key,
              );
              return FilterChip(
                label: Text(LocaleHelper.getLabel(context, key)),
                selected: isSelected,
                onSelected: (_) => controller.toggleAdmissionType(key),
                selectedColor: AppColors.secondary.withOpacity(0.2),
                checkmarkColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildRadioOption(
    BuildContext context, {
    required bool value,
    required bool groupValue,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColors.primaryLight,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primaryLight : null,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
