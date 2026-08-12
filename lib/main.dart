import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/providers/app_language_provider.dart';
import 'package:news/providers/app_theme_provider.dart';
import 'package:news/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            AppLanguageProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            AppThemeProvider();
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: 'home_page',
      themeMode: Provider.of<AppThemeProvider>(context).themeMode,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
    );
  }
}
