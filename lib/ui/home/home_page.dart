import 'package:flutter/material.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/ui/home/category_details/source/category_details.dart';
import 'package:news/ui/home/drawer/home_drawer.dart';
import 'package:news/ui/home/search_screen.dart';
import 'package:news/utils/size_utils.dart';

import 'category_fragment/category_fragment.dart';
import 'category_fragment/localized_category_title.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  Widget build(BuildContext context) {
    var key = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: Drawer(

        width: context.scaleWidth(269),
        backgroundColor: Colors.black,

        child: HomeDrawer(onDrawerItemClick: onDraweritemClick,),
      ),
        appBar: AppBar(title: selectedCategory == null ?
        Text(AppLocalizations.of(context)!.home) : Text(
            getLocalizedTitle(key, selectedCategory!.id)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                );
              },
            ),
          ],

        ),
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,

        body: selectedCategory == null
            ?
        CategoryFragment(onCategoryClick: onCategoryItemClick,)
            : CategoryDetails(category: selectedCategory!,)
    );
  }

  ApiCategory ? selectedCategory;

  void onCategoryItemClick(ApiCategory newCategory) {
    selectedCategory = newCategory;
    setState(() {

    });
  }

  void onDraweritemClick() {
    selectedCategory = null;
    setState(() {
      Navigator.pop(context);
    });
  }
}
