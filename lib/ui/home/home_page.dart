import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/ui/home/category_details/category_fragment/category_fragment.dart';
import 'package:news/ui/home/drawer/home_drawer.dart';
import 'package:news/utils/size_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        width: context.scaleWidth(269),
        backgroundColor: Colors.black,

        child: const HomeDrawer(),
      ),
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.general),),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CategoryFragment(),
    );
  }
}
