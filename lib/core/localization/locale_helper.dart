import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleHelper {
  /// Maps internal keys (e.g., 'gov_amman') to localized strings from ARB.
  static String getLabel(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    
    final Map<String, String> mapping = {
      "gov_amman": l10n.gov_amman,
      "gov_irbid": l10n.gov_irbid,
      "gov_zarqa": l10n.gov_zarqa,
      "gov_balqa": l10n.gov_balqa,
      "gov_madaba": l10n.gov_madaba,
      "gov_mafraq": l10n.gov_mafraq,
      "gov_jerash": l10n.gov_jerash,
      "gov_ajloun": l10n.gov_ajloun,
      "gov_karak": l10n.gov_karak,
      "gov_tafila": l10n.gov_tafila,
      "gov_maan": l10n.gov_maan,
      "gov_aqaba": l10n.gov_aqaba,

      "pt_public": l10n.pt_public,
      "pt_private": l10n.pt_private,
      "pt_regional": l10n.pt_regional,

      "at_competitive": l10n.at_competitive,
      "at_parallel": l10n.at_parallel,
      "at_moukarama": l10n.at_moukarama,
      "at_scholarship": l10n.at_scholarship,

      "opt_no": l10n.opt_no,
      "opt_sometimes": l10n.opt_sometimes,
      "opt_yes": l10n.opt_yes,

      "chance_safe": l10n.chance_safe,
      "chance_competitive": l10n.chance_competitive,
      "chance_ambitious": l10n.chance_ambitious,
      "chance_hard": l10n.chance_hard,

      "track_it": l10n.track_it,
      "track_eng": l10n.track_eng,
      "track_health": l10n.track_health,
      "track_science": l10n.track_science,
      "track_business": l10n.track_business,
      "track_humanities": l10n.track_humanities,
      "track_law": l10n.track_law,
      "track_edu": l10n.track_edu,
    };

    return mapping[key] ?? key;
  }
}
