import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/localization/locale_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FiltersDropdown extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final bool isLocalized;

  const FiltersDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.isLocalized = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
          ),
          items: options.map((opt) {
            String displayText;
            if (opt == "All") {
              displayText = l10n.all;
            } else if (isLocalized) {
              displayText = LocaleHelper.getLabel(context, opt);
            } else {
              displayText = opt;
            }

            return DropdownMenuItem(
              value: opt,
              child: Text(displayText, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
