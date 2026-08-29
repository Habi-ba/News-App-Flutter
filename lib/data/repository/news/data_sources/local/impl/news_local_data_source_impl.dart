import 'package:hive_ce/hive.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/data/repository/news/data_sources/local/news_local_data_source.dart';

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  @override
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    var box = await Hive.openBox('News');
    var response = box.get(sourceId) as NewsResponse?;
    return response;
  }

  @override
  Future<void> saveNews(NewsResponse newsResponse, String sourceId) async {
    var box = await Hive.openBox('News');
    await box.put(sourceId, newsResponse);
  }
}
