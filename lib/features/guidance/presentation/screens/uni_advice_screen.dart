import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_drawer.dart';

class UniAdviceScreen extends StatelessWidget {
  const UniAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, l10n, theme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.advice_subtitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildAdviceSection(
                    context,
                    l10n.advice_cat_selection,
                    l10n.advice_cat_selection_desc,
                    Icons.explore_outlined,
                    AppColors.primaryLight,
                  ),
                  _buildAdviceSection(
                    context,
                    l10n.advice_cat_academic,
                    l10n.advice_cat_academic_desc,
                    Icons.auto_stories_outlined,
                    Colors.orangeAccent,
                  ),
                  _buildAdviceSection(
                    context,
                    l10n.advice_cat_social,
                    l10n.advice_cat_social_desc,
                    Icons.people_outline,
                    Colors.blueAccent,
                  ),
                  _buildAdviceSection(
                    context,
                    l10n.advice_cat_market,
                    l10n.advice_cat_market_desc,
                    Icons.trending_up_outlined,
                    Colors.purpleAccent,
                  ),
                  _buildAdviceSection(
                    context,
                    l10n.advice_cat_tradition,
                    l10n.advice_cat_tradition_desc,
                    Icons.mosque_outlined,
                    Colors.teal,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: theme.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          l10n.advice_title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black45, blurRadius: 10)],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/Gemini_Generated_Image_rqf8c7rqf8c7rqf8.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.primaryColor.withOpacity(0.8),
                child: const Icon(Icons.school, size: 80, color: Colors.white54),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceSection(
    BuildContext context,
    String title,
    String desc,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
