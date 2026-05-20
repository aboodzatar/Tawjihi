import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/core/utils/constants.dart';
import 'package:tawjihi_new/data/models/major_model.dart';
import 'package:tawjihi_new/core/localization/locale_helper.dart';

class MajorCard extends StatelessWidget {
  final MajorModel major;
  final VoidCallback onTap;

  const MajorCard({super.key, required this.major, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              major.name.localized,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${major.university.localized} - ${major.location.localized}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.secondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80), // Space for banner
                    ],
                  ),
                  if (major.compatibilityScore != null) ...[
                    const SizedBox(height: 8),
                    _buildMatchScoreIndicator(
                      context,
                      major.compatibilityScore!,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildIconText(
                        Icons.account_balance,
                        LocaleHelper.getLabel(context, major.universityType),
                        theme,
                      ),
                      const SizedBox(width: 12),
                      _buildIconText(
                        Icons.timer,
                        "${major.duration}${l10n.years.substring(0, 1)}",
                        theme,
                      ),
                      const SizedBox(width: 12),
                      _renderTrendIcon(major.trendDirection, theme, l10n),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // PREDICTED GRADES ROW
                  Row(
                    children: [
                      _buildPredictionBadge(
                        l10n.label_tanafos ?? 'Tanafos',
                        major.predictedTanafos,
                        Colors.blue,
                      ),
                      if (major.predictedMowazi != null) ...[
                        const SizedBox(width: 8),
                        _buildPredictionBadge(
                          l10n.label_mowazi ?? 'Mowazi',
                          major.predictedMowazi!,
                          Colors.purple,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    major.aiDisclaimer.localized,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Divider(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          major.incomeRange,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.view_details,
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: _buildChanceBanner(context, major.predictedChance),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchScoreIndicator(BuildContext context, double score) {
    final l10n = AppLocalizations.of(context)!;
    Color color;
    if (score >= 80)
      color = Colors.green;
    else if (score >= 60)
      color = Colors.orange;
    else
      color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            l10n.match_score(score.toStringAsFixed(0)),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChanceBanner(BuildContext context, String chance) {
    final l10n = AppLocalizations.of(context)!;
    Color color;
    String text;

    switch (chance) {
      case "Safe":
      case "High":
        color = Colors.green;
        text = l10n.localeName == 'ar' ? "مضمون" : "Safe";
        break;
      case "Competitive":
        color = Colors.orange;
        text = l10n.localeName == 'ar' ? "تنافسي" : "Competitive";
        break;
      case "Ambitious":
        color = Colors.red;
        text = l10n.localeName == 'ar' ? "صعب" : "Hard";
        break;
      default:
        color = Colors.grey;
        text = chance;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(AppConstants.borderRadius),
          bottomStart: const Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(-2, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPredictionBadge(String label, double grade, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            grade.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: theme.textTheme.bodySmall?.copyWith(fontSize: 10)),
      ],
    );
  }

  Widget _renderTrendIcon(
    String trend,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    IconData icon;
    String label;
    Color color;

    switch (trend) {
      case "Rising":
      case "Up":
        icon = Icons.trending_up;
        label = l10n.trend_rising ?? "Rising";
        color = Colors.green;
        break;
      case "Falling":
      case "Down":
        icon = Icons.trending_down;
        label = l10n.trend_falling ?? "Falling";
        color = Colors.red;
        break;
      default:
        icon = Icons.trending_flat;
        label = l10n.trend_steady ?? "Stable";
        color = Colors.grey;
    }

    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 10,
            color: color,
          ),
        ),
      ],
    );
  }
}
