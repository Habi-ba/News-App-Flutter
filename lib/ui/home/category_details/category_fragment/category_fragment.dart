import 'package:flutter/material.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/ui/home/category_details/category_fragment/category_item.dart';
import 'package:news/utils/size_utils.dart';

typedef OnCategoryClick = void Function(ApiCategory);

class CategoryFragment extends StatelessWidget {
  final OnCategoryClick onCategoryClick;

  const CategoryFragment({super.key, required this.onCategoryClick});

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
                return InkWell(
                  onTap: () {
                    //todo:click
                    onCategoryClick(categoriesList[index]);
                  },
                  child: CategoryItem(
                    category: categoriesList[index],
                    index: index,
                  ),
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
