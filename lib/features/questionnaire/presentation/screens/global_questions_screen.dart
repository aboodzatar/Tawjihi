import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../controller/questionnaire_controller.dart';
import '../../../../data/mock/mock_questions_data.dart';

import '../../../../core/widgets/persistent_app_bar.dart';

class GlobalQuestionsScreen extends GetView<QuestionnaireController> {
  const GlobalQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PersistentAppBar(
        title: l10n.nav_quiz,
        showLogo: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Obx(() => LinearProgressIndicator(
            value: controller.progress,
            backgroundColor: Colors.grey.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
          )),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l10n.global_questions_desc,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ...controller.questions.map((q) => _buildQuestionCard(context, q)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => controller.submit(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: AppColors.primaryLight,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Obx(() => controller.isSubmitting.value 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(l10n.submit, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildQuestionCard(BuildContext context, QuestionnaireQuestion q) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Theme.of(context).cardColor.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q.text.localized,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Obx(() => Row(
              children: q.options.map<Widget>((opt) {
                final isSelected = controller.answers[q.id] == opt.key;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () => controller.updateAnswer(q.id, opt.key),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryLight : Colors.transparent,
                          border: Border.all(color: isSelected ? AppColors.primaryLight : Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          opt.text.localized,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }
}
