import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/providers/app_language_provider.dart';
import 'package:news/providers/app_theme_provider.dart';
import 'package:news/ui/home/home_page.dart';
import 'package:news/ui/home/my_bloc_observer.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return AppLanguageProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return AppThemeProvider();
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
      routes: {AppRoutes.homePage: (context) => HomePage()},
      themeMode: Provider.of<AppThemeProvider>(context).themeMode,
      locale: Provider.of<AppLanguageProvider>(context).locale,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
    );
  }
}
