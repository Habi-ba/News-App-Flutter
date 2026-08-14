import 'package:flutter/material.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/ui/home/category_details/category_fragment/category_item.dart';
import 'package:news/utils/size_utils.dart';

class CategoryFragment extends StatelessWidget {
  const CategoryFragment({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var key = AppLocalizations.of(context)!;
    var categoriesList = ApiCategory.getCategoriesList();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(16),
        vertical: context.scaleHeight(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(key.goodMorning, style: theme.textTheme.bodyMedium),

          Text(key.hereIsSomeNewsForYou, style: theme.textTheme.bodyMedium),

          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CategoryItem(
                  category: categoriesList[index],
                  index: index,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemCount: categoriesList.length,
            ),
          ),
        ],
      ),
    );
  }
}
