import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tawjihi_new/core/routes/route_names.dart';
import 'package:tawjihi_new/data/models/major_model.dart';
import 'package:tawjihi_new/features/majors/controller/major_details_controller.dart';

import '../widgets/detail_section_card.dart';
import '../widgets/info_row.dart';
import '../widgets/tag_chip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/core/utils/constants.dart';
import 'package:tawjihi_new/core/widgets/error_widget.dart';
import 'package:tawjihi_new/core/widgets/loading_widget.dart';
import 'package:tawjihi_new/core/widgets/persistent_app_bar.dart';
import 'package:tawjihi_new/core/localization/locale_helper.dart';

class MajorDetailsScreen extends StatelessWidget {
  const MajorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentId = Get.parameters['id'] ?? (Get.arguments as String?);
    final controller = Get.put(MajorDetailsController(), tag: currentId);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: PersistentAppBar(
        title: l10n.details,
        showLogo: false,
        showHomeOption: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.major.value == null) {
                return const LoadingWidget();
              }

              if (controller.hasError.value) {
                return ErrorViewWidget(
                  message: controller.errorMessage.value,
                  onRetry: controller.loadMajorDetails,
                );
              }

              final major = controller.major.value;
              if (major == null) {
                return const Center(child: Text("Major not found"));
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBasicInfo(context, major, l10n),
                        _buildPrediction(context, major, l10n),
                        _buildStudyDetails(major, l10n),
                        _buildSkills(major, l10n),
                        _buildCareer(major, l10n),
                        _buildIncome(major, l10n),
                        _buildAdvancedPaths(major, l10n),
                        _buildProsCons(major, l10n),
                        _buildRisk(major, l10n),
                        _buildROI(major, l10n),
                        _buildContacts(controller, l10n),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          Obx(() => _buildAIConsultCard(context, controller.major.value, l10n)),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context, MajorModel major, AppLocalizations l10n) {
    final uniTypeLabel = LocaleHelper.getLabel(context, major.universityType);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          major.name.localized,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.account_balance, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${major.university.localized} • $uniTypeLabel',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              major.location.localized,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          major.description.localized,
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPrediction(
    BuildContext context,
    MajorModel major,
    AppLocalizations l10n,
  ) {
    final chanceColor = _getChanceColor(major.predictedChance);

    return DetailSectionCard(
      title: l10n.prediction_title ?? 'Admission AI Prediction',
      icon: Icons.auto_awesome,
      child: Column(
        children: [
          Row(
            children: [
              _buildLargePredictionBadge(
                l10n.label_tanafos ?? "Tanafos",
                major.predictedTanafos,
                AppColors.primaryLight,
              ),
              const SizedBox(width: 12),
              _buildLargePredictionBadge(
                l10n.label_mowazi ?? "Mowazi",
                major.predictedMowazi ?? 0,
                Colors.deepPurpleAccent,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: chanceColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.query_stats, color: chanceColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.prediction_chance ?? "Admission Chance",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        _localizeValue(context, major.predictedChance),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: chanceColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${(major.confidenceScore * 100).toInt()}% ${l10n.confidence ?? 'Confidence'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: chanceColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.label_historical ?? 'Historical Min Grades:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  major.historicalAcceptanceData.map((h) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            h['year'].toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            h['minGrade'].toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargePredictionBadge(String label, double grade, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              grade == 0 ? "N/A" : grade.toStringAsFixed(1),
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudyDetails(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_study,
      icon: Icons.book_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailWithReason(
            icon: Icons.timer,
            label: l10n.label_duration,
            value: '${major.duration} ${l10n.years}',
            reason: "",
            color: AppColors.primaryLight,
          ),
          const SizedBox(height: 12),
          _buildDetailWithReason(
            icon: Icons.bolt,
            label: l10n.label_intensity,
            value: major.studyIntensity,
            reason: major.intensityReason.localized,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildDetailWithReason(
            icon: Icons.psychology,
            label: l10n.label_difficulty,
            value: major.difficultyLevel,
            reason: major.difficultyReason.localized,
            color: Colors.redAccent,
          ),
          const Divider(height: 32),
          Text(
            l10n.label_main_subjects,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                major.mainSubjects
                    .map(
                      (subject) => InkWell(
                        onTap:
                            () => _showDetailedInfo(
                              subject.name.localized,
                              subject.description.localized,
                            ),
                        borderRadius: BorderRadius.circular(20),
                        child: TagChip(
                          label: subject.name.localized,
                          color: AppColors.primaryLight.withOpacity(0.1),
                          textColor: AppColors.primaryDark,
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.click_subject_hint,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailWithReason({
    required IconData icon,
    required String label,
    required String value,
    required String reason,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (reason.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 4, right: 8),
            child: Text(
              reason,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  void _showDetailedInfo(String title, String description) {
    final context = Get.context!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.primaryLight),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSkills(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_skills,
      icon: Icons.psychology_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.label_core_skills,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                major.coreSkills
                    .map(
                      (skill) => InkWell(
                        onTap:
                            () => _showDetailedInfo(
                              skill.name.localized,
                              skill.description.localized,
                            ),
                        borderRadius: BorderRadius.circular(20),
                        child: TagChip(
                          label: skill.name.localized,
                          color: Colors.orange.withOpacity(0.1),
                          textColor: Colors.orange.shade900,
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.person_outline,
            label: l10n.label_personality,
            value: major.suitedPersonality.localized,
          ),
        ],
      ),
    );
  }

  Widget _buildCareer(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_career,
      icon: Icons.work_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMarketInfoRow(
            icon: Icons.event_available,
            label: l10n.label_job_availability,
            value: major.jobAvailability,
            helpTitle: l10n.label_job_availability,
            helpDescription:
                l10n.explain_job_availability ??
                "Refers to the number of open positions currently available for new graduates in the Jordanian market.",
          ),
          _buildMarketInfoRow(
            icon: Icons.pie_chart_outline,
            label: l10n.label_market_saturation,
            value: major.marketSaturation,
            helpTitle: l10n.label_market_saturation,
            helpDescription:
                l10n.explain_market_saturation ??
                "Indicates how many graduates are already in this field compared to the actual demand from employers.",
          ),
          const SizedBox(height: 16),
          Text(
            l10n.label_career_paths,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                major.careerPaths
                    .map(
                      (p) => InkWell(
                        onTap:
                            () => _showDetailedInfo(
                              p.name.localized,
                              p.description.localized,
                            ),
                        borderRadius: BorderRadius.circular(20),
                        child: TagChip(
                          label: p.name.localized,
                          color: AppColors.primaryLight.withOpacity(0.1),
                          textColor: AppColors.primaryDark,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required String helpTitle,
    required String helpDescription,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Icon(icon, size: 20, color: Colors.grey.shade600),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () => _showDetailedInfo(helpTitle, helpDescription),
                  icon: Icon(
                    Icons.help_outline,
                    size: 16,
                    color: Colors.blue.withOpacity(0.6),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncome(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_income,
      icon: Icons.payments_outlined,
      child: Column(
        children: [
          InfoRow(
            icon: Icons.money,
            label: l10n.label_income_range,
            value: major.incomeRange,
            valueColor: Colors.green,
          ),
          InfoRow(
            icon: Icons.trending_up,
            label: l10n.label_income_growth,
            value: major.incomeGrowth,
          ),
          InfoRow(
            icon: Icons.shield_outlined,
            label: l10n.label_income_stability,
            value: major.incomeStability,
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedPaths(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_advanced,
      icon: Icons.school_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.label_masters,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                major.mastersSpecializations
                    .map(
                      (s) => TagChip(
                        label: s.localized,
                        color: AppColors.primaryLight.withOpacity(0.1),
                        textColor: AppColors.primaryDark,
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 16),
          InfoRow(
            icon: Icons.public,
            label: l10n.label_international,
            value: major.internationalOpportunities.localized,
          ),
        ],
      ),
    );
  }

  Widget _buildProsCons(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_pros_cons,
      icon: Icons.thumbs_up_down_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.label_pros,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          ...major.pros.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• ${p.localized}',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.label_cons,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          ...major.cons.map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• ${c.localized}',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRisk(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_risk,
      icon: Icons.warning_amber_outlined,
      child: InfoRow(
        icon: Icons.psychology_alt,
        label: l10n.label_not_suitable,
        value: major.notSuitableFor.localized,
      ),
    );
  }

  Widget _buildROI(MajorModel major, AppLocalizations l10n) {
    return DetailSectionCard(
      title: l10n.section_roi,
      icon: Icons.assignment_return_outlined,
      child: Column(
        children: [
          _buildMarketInfoRow(
            icon: Icons.timer_outlined,
            label: l10n.label_time_to_income,
            value: major.timeToIncome,
            helpTitle: l10n.label_time_to_income,
            helpDescription:
                l10n.explain_time_to_income ??
                "The estimated time it takes for a graduate to secure their first job and start earning a stable income in Jordan.",
          ),
          _buildMarketInfoRow(
            icon: Icons.star_border,
            label: l10n.label_demand_return,
            value: '${(major.demandVsReturn * 100).toInt()}%',
            helpTitle: l10n.label_demand_return,
            helpDescription:
                l10n.explain_demand_return ??
                "A comparison between market demand for this major and the expected financial return (salary) over time.",
          ),
          _buildMarketInfoRow(
            icon: Icons.compare_arrows,
            label: l10n.label_flexibility,
            value: '${(major.flexibilityScore * 100).toInt()}%',
            helpTitle: l10n.label_flexibility,
            helpDescription:
                l10n.explain_flexibility ??
                "How easily a graduate can switch between different sub-fields, work remotely, or transition to related careers.",
          ),
        ],
      ),
    );
  }

  Widget _buildContacts(
    MajorDetailsController controller,
    AppLocalizations l10n,
  ) {
    return DetailSectionCard(
      title: l10n.section_contacts,
      icon: Icons.people_outline,
      child:
          controller.graduates.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    l10n.no_graduates,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
              : Column(
                children:
                    controller.graduates
                        .map(
                          (contact) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(contact.name.localized),
                            subtitle: Text("Class of ${contact.gradYear}"),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.link,
                                color: AppColors.primaryLight,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )
                        .toList(),
              ),
    );
  }

  Widget _buildAIConsultCard(
    BuildContext context,
    MajorModel? major,
    AppLocalizations l10n,
  ) {
    if (major == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton.icon(
          onPressed: () {
            final String contextMsg = l10n.localeName == 'ar'
                ? 'أريد أن أسأل عن تخصص ${major.name.localized} في ${major.university.localized}.'
                : 'I want to ask about the ${major.name.localized} major at ${major.university.localized}.';
            Get.toNamed(RouteNames.aiChat, arguments: contextMsg);
          },
          icon: const Icon(Icons.chat_bubble_outline),
          label: Text(
            l10n.chat_with_ai_about_major ?? "Consult AI about this Major",
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Color _getChanceColor(String chance) {
    switch (chance) {
      case "High":
        return Colors.green;
      case "Competitive":
        return Colors.orange;
      case "Ambitious":
        return Colors.red;
      case "Safe":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _localizeValue(BuildContext context, String value) {
    if (Localizations.localeOf(context).languageCode != 'ar') return value;
    const map = {
      'Safe': 'مضمون',
      'High': 'مرتفع',
      'Competitive': 'تنافسي',
      'Ambitious': 'صعب',
      'Unknown': 'غير معروف',
      'Rising': 'تصاعدي',
      'Falling': 'تنازلي',
      'Stable': 'مستقر',
    };
    return map[value] ?? value;
  }
}
