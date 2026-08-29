import 'package:news/api/model/news/news_response.dart';

abstract class NewsRepository {
  Future<NewsResponse?> getNewsBySourceId(String sourceID);
}
