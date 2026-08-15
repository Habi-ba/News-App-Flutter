import '../../../../l10n/app_localizations.dart';

String getLocalizedTitle(AppLocalizations key, String categoryId) {
  switch (categoryId) {
    case 'general':
      return key.general;
    case 'business':
      return key.business;
    case 'sports':
      return key.sports;
    case 'technology':
      return key.technology;
    case 'health':
      return key.health;
    case 'entertainment':
      return key.entertainment;
    case 'science':
      return key.science;
    default:
      return categoryId;
  }
}
