import 'package:flutter/material.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/utils/size_utils.dart';

import 'localized_category_title.dart';

class CategoryItem extends StatelessWidget {
  final ApiCategory category;
  final int index;

  const CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isEven = (index % 2 == 0);
    var theme = Theme.of(context);
    var key = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AspectRatio(aspectRatio: 1.8, child: category.image),
          ),
        ),

        // العنوان — مكانه ثابت (يمين فعلي أو شمال فعلي) بغض النظر عن اللغة
        Positioned(
          top: context.scaleHeight(50),
          right: isEven ? context.scaleWidth(30) : null,
          left: !isEven ? context.scaleWidth(30) : null,
          child: Text(
            getLocalizedTitle(key, category.id),
            style: theme.textTheme.bodyLarge,
          ),
        ),

        Positioned(
          bottom: context.scaleHeight(20),
          right: isEven ? context.scaleWidth(20) : null,
          left: !isEven ? context.scaleWidth(20) : null,
          child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: theme.canvasColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: isEven
                  ? [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(12)),
                  child: Text(key.viewAll, style: theme.textTheme.bodyMedium),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.cardColor,
                  child: Icon(Icons.arrow_forward_ios_outlined,
                      color: theme.iconTheme.color),
                ),
              ]
                  : [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.cardColor,
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: theme.iconTheme.color),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(12)),
                  child: Text(key.viewAll, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}