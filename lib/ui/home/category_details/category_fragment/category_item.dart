import 'package:flutter/material.dart';
import 'package:news/api/model/category/category.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/utils/size_utils.dart';

class CategoryItem extends StatelessWidget {
  final ApiCategory category;
  final int index;

  const CategoryItem({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isEven = (index % 2 == 0);
    var theme = Theme.of(context);
    var key = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment:
              isEven
                  ? AlignmentDirectional.bottomEnd
                  : AlignmentDirectional.bottomStart,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: AspectRatio(aspectRatio: 1.8, child: category.image),
              ),
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: context.scaleHeight(20),
              children: [
                Text(category.title, style: theme.textTheme.bodyLarge),

                Container(
                  margin: EdgeInsetsDirectional.symmetric(
                    horizontal: context.scaleWidth(20),
                    vertical: context.scaleHeight(20),
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: isEven ? context.scaleWidth(20) : 0,
                    end: !isEven ? context.scaleWidth(20) : 0,
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: theme.canvasColor,
                  ),
                  child: Row(
                    spacing: context.scaleWidth(4),
                    mainAxisSize: MainAxisSize.min,
                    textDirection:
                        isEven ? TextDirection.ltr : TextDirection.rtl,

                    children: [
                      Text(key.viewAll, style: theme.textTheme.bodyMedium),

                      CircleAvatar(
                        radius: 30,
                        backgroundColor: theme.cardColor,
                        child: Icon(
                          isEven
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.arrow_back_ios_new_outlined,
                          color: theme.iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
