import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/api/model/news/news.dart';
import 'package:news/ui/home/widget/main_loading_widget.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/size_utils.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: context.scaleHeight(322),
        width: context.scaleWidth(361),
        margin: EdgeInsets.symmetric(horizontal: context.scaleWidth(5)),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// News Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1.8,
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage ?? '',
                  placeholder: (context, url) => MainLoadingWidget(),
                  errorWidget:
                      (context, url, error) => Icon(Icons.error_outline),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Spacer(),

            /// Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(5)),
              child: Text(
                news.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),

            Spacer(),

            /// Author + Time
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                //textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: Text(
                      'By : ${news.author ?? 'Unknown'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.med12Gray,
                    ),
                  ),

                  Spacer(),

                  Text(_getTime(news.publishedAt), style: AppStyles.med12Gray),
                ],
              ),
            ),

            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  String _getTime(String? publishedAt) {
    if (publishedAt == null || publishedAt.isEmpty) {
      return '';
    }

    try {
      final date = DateTime.parse(publishedAt);
      final difference = DateTime.now().difference(date);

      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      }

      if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      }

      return '${difference.inDays} days ago';
    } catch (_) {
      return '';
    }
  }
}
