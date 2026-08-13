import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/ui/home/category_details/source/category_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.general)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CategoryDetails(),
    );
  }
}
