import 'package:news/api/model/news/news_response.dart';

abstract class NewsLocalDataSource {
  Future<NewsResponse?> getNewsBySourceId(String sourceId);

  Future<void> saveNews(NewsResponse newsResponse, String sourceId);
}
