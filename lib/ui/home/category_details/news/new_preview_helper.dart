import 'package:flutter/material.dart';
import 'package:news/utils/size_utils.dart';

import '../../../../api/model/news/news.dart';
import '../../../../l10n/app_localizations.dart';
import 'full_article_screen.dart';


void showNewsPreview(BuildContext context, News article) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: context.scaleWidth(14),
          vertical: context.scaleHeight(14),
        ),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .dividerColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16)),
                child: article.urlToImage != null
                    ? Image.network(
                  article.urlToImage!,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        height: 180,
                        color: Colors.grey[800],
                        child: const Icon(
                            Icons.image_not_supported, color: Colors.white54),
                      ),
                )
                    : Container(
                  height: 180,
                  color: Colors.grey[800],
                  child: const Icon(
                      Icons.image_not_supported, color: Colors.white54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  article.description ??
                      AppLocalizations.of(context)!.no_description_found,
                  style: Theme
                      .of(context)
                      .textTheme
                      .displaySmall,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: context.scaleHeight(56),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullArticleScreen(news: article),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                      ),
                      backgroundColor: Theme
                          .of(context)
                          .cardColor,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.view_full_article,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}