import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../onboarding/controller/onboarding_controller.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller should already exist from onboarding or we put it now
    final controller =
        Get.isRegistered<OnboardingController>()
            ? Get.find<OnboardingController>()
            : Get.put(OnboardingController());

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.edit_profile ?? "Edit Information")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context)),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, l10n),
                const SizedBox(height: 32),

                // Governorate
                _buildSectionTitle(
                  l10n.governorate_label ?? "Governorate",
                  theme,
                ),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedGovernorate.value,
                    items:
                        AppConstants.governorates
                            .map(
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
                            )
                            .toList(),
                    onChanged: (v) => controller.selectedGovernorate.value = v!,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Open to other governorates
                Obx(
                  () => SwitchListTile(
                    title: Text(
                      l10n.open_to_other_gov ??
                          "Willing to study in other governorates?",
                    ),
                    value: controller.openToOtherGovernorate.value,
                    onChanged:
                        (v) => controller.openToOtherGovernorate.value = v,
                  ),
                ),
                const Divider(height: 32),

                // Program Types
                _buildSectionTitle(
                  l10n.program_types_label ?? "Program Types",
                  theme,
                ),
                Wrap(
                  spacing: 8,
                  children:
                      AppConstants.programTypes
                          .map(
                            (type) => Obx(
                              () => FilterChip(
                                label: Text(type),
                                selected: controller.selectedProgramTypes
                                    .contains(type),
                                onSelected:
                                    (_) => controller.toggleProgramType(type),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 24),

                // Admission Types
                _buildSectionTitle(
                  l10n.admission_types_label ?? "Admission Channels",
                  theme,
                ),
                Wrap(
                  spacing: 8,
                  children:
                      AppConstants.admissionTypes
                          .map(
                            (type) => Obx(
                              () => FilterChip(
                                label: Text(type),
                                selected: controller.selectedAdmissionTypes
                                    .contains(type),
                                onSelected:
                                    (_) => controller.toggleAdmissionType(type),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 48),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : () async {
                                await controller.saveAndContinue();
                                Get.snackbar(
                                  "Success",
                                  "Information updated successfully",
                                );
                                Get.back();
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: Colors.white,
                      ),
                      child:
                          controller.isLoading.value
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Update your preferences",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "Changes will reflect in your results instantly.",
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
