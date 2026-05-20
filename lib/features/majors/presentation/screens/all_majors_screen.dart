import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/features/majors/controller/majors_controller.dart';
import '../widgets/major_card.dart';
import '../widgets/filters_dropdown.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/persistent_app_bar.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/routes/route_names.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../../../core/utils/shared_prefs_helper.dart';
import '../../../../features/auth/controller/auth_controller.dart';

class AllMajorsScreen extends StatefulWidget {
  const AllMajorsScreen({super.key});

  @override
  State<AllMajorsScreen> createState() => _AllMajorsScreenState();
}

class _AllMajorsScreenState extends State<AllMajorsScreen> {
  final controller = MajorsController.to;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PersistentAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilters(context, controller, l10n, theme),
          Obx(() {
            final selected = controller.selectedType.value;
            if (selected == 'All') return const SizedBox.shrink();

            List<String> profileTypes = [];
            try {
              final student = AuthController.to.currentStudent.value;
              if (student != null) {
                final prefs = SharedPrefsHelper.getPreferences(student.id);
                if (prefs != null && prefs.containsKey(AppConstants.keyProgramTypes)) {
                  profileTypes = List<String>.from(prefs[AppConstants.keyProgramTypes]);
                }
              }
              if (profileTypes.isEmpty && Get.isRegistered<ProfileController>()) {
                profileTypes = Get.find<ProfileController>().selectedProgramTypes.toList();
              }
            } catch (_) {}

            final isConflict = !profileTypes.contains(selected);
            if (!isConflict) return const SizedBox.shrink();

            final conflictMessage = selected == 'pt_private'
                ? (l10n.msg_filter_conflict_private ?? 'You didn\'t select Private Universities in your profile settings.')
                : (l10n.msg_filter_conflict_public ?? 'You didn\'t select Public Universities in your profile settings.');

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      conflictMessage,
                      style: const TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed('/profile'),
                    child: Text(
                      l10n.nav_profile ?? 'Profile',
                      style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final majors = controller.filteredMajors;
              if (majors.isEmpty) {
                return Center(child: Text(l10n.no_majors_found));
              }

              return GridView.builder(
                padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.getGridColumnCount(context),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 250,
                ),
                itemCount: majors.length,
                itemBuilder: (context, index) {
                  final major = majors[index];
                  return MajorCard(
                    major: major,
                    onTap: () => Get.toNamed(
                      RouteNames.majorDetails,
                      parameters: {'id': major.id},
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(
    BuildContext context, 
    MajorsController controller, 
    AppLocalizations l10n, 
    ThemeData theme
  ) {
    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: (val) {
              controller.searchQuery.value = val;
            },
            decoration: InputDecoration(
              hintText: l10n.nav_majors, 
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return isWide 
                  ? Row(
                      children: [
                        Expanded(child: _buildTypeDropdown(controller, l10n)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildChanceDropdown(controller, l10n)),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildTypeDropdown(controller, l10n)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildChanceDropdown(controller, l10n)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => controller.resetFilters(),
                                child: Text(l10n.reset_filters),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypeDropdown(MajorsController controller, AppLocalizations l10n) {
    return Obx(() => FiltersDropdown(
      label: l10n.filter_by_type,
      selectedValue: controller.selectedType.value,
      options: ["All", ...AppConstants.programTypeKeys],
      onChanged: (val) {
        controller.selectedType.value = val!;
      },
    ));
  }

  Widget _buildChanceDropdown(MajorsController controller, AppLocalizations l10n) {
    return Obx(() => FiltersDropdown(
      label: l10n.filter_by_chance,
      selectedValue: controller.selectedChance.value,
      options: const ["All", "chance_safe", "chance_competitive", "chance_hard"],
      isLocalized: true, 
      onChanged: (val) {
        controller.selectedChance.value = val!;
      },
    ));
  }
}
