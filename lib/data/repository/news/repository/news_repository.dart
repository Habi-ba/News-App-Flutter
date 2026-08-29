import '../../../../api/model/news/news_response.dart';

abstract class NewsRepository {
  Future<NewsResponse?> getNewsBySourceId(String sourceId,
      {int page = 1}); // ✅ إضافة page
}