import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onReset;
  final IconData? icon;

  const EmptyStateWidget({
    super.key, 
    this.message, 
    this.onReset,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.search_off, size: 80, color: Colors.grey.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              message ?? (l10n.no_majors_found ?? "No results found"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            if (onReset != null) ...[
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: onReset,
                child: Text(l10n.reset_filters ?? "Reset Filters"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
