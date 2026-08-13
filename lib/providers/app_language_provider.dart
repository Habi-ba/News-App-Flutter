import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLanguage(String languageCode) {
    if (_locale.languageCode == languageCode) {
      return;
    }
    _locale = Locale(languageCode);
    notifyListeners();
  }
}