import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/routes/route_names.dart';
import '../../../majors/presentation/widgets/major_card.dart';
import '../../controller/suggested_majors_controller.dart';

import '../../../../core/widgets/persistent_app_bar.dart';

class SuggestedMajorsScreen extends GetView<SuggestedMajorsController> {
  const SuggestedMajorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light 
          ? AppColors.backgroundLight 
          : AppColors.backgroundDark,
      appBar: PersistentAppBar(
        title: l10n.suggested_majors_title,
        showLogo: false,
        showHomeOption: true,
        onRetakeSurvey: controller.retakeSurvey,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState(context, l10n);
        }

        if (controller.suggestedMajors.isEmpty) {
          return _buildEmptyState(context, l10n);
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryDark, AppColors.primaryLight],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryLight.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.auto_awesome, color: Colors.amber, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  l10n.suggested_majors_title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.suggested_majors_desc,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline, color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    l10n.localeName == 'ar' 
                                      ? "كيف تم الحساب؟\nتعتمد نسبة التطابق (%) على دمج درجات اهتماماتك (من إجاباتك) مع فرص قبولك الأكاديمية (معدلك التوجيهي)."
                                      : "How is it calculated?\nThe Match % combines your interest score (from your answers) with your academic eligibility (Tawjihi grade).",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        context,
                        ["All", "Safe", "Competitive", "Hard"],
                        controller.selectedChance,
                        l10n.localeName == 'ar' ? "الفرصة" : "Chance",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isTablet(context) ? 2 : 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 250,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final major = controller.filteredSuggestedMajors[index];
                    return MajorCard(
                      major: major,
                      onTap: () => Get.toNamed(
                        RouteNames.majorDetails,
                        parameters: {'id': major.id},
                      ),
                    );
                  },
                  childCount: controller.filteredSuggestedMajors.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.viewAllMajors,
                      icon: const Icon(Icons.list_alt_rounded),
                      label: Text(l10n.view_all_majors),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: controller.retakeSurvey,
                      child: Text(l10n.retake_questionnaire),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildFilterDropdown(
    BuildContext context,
    List<String> items,
    RxString rxValue,
    String hint,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: rxValue.value,
          dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 14)),
          items: items.map((item) {
            String label = item;
            if (item == "All") label = "الكل";
            if (item == "Safe") label = "مضمون";
            if (item == "Competitive") label = "تنافسي";
            if (item == "Hard") label = "صعب";
            if (item == "Amman") label = "عمان";
            if (item == "Irbid") label = "إربد";
            if (item == "Zarqa") label = "الزرقاء";
            if (item == "Karak") label = "الكرك";
            if (item == "Balqa") label = "البلقاء";

            return DropdownMenuItem(
              value: item,
              child: Text(label, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) rxValue.value = val;
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          Text(
            l10n.matching_in_progress,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 24),
            Text(
              l10n.no_majors_found,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.retakeSurvey,
              child: Text(l10n.retake_questionnaire),
            ),
          ],
        ),
      ),
    );
  }
}
