import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/data/repository/news/data_sources/local/news_local_data_source.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';

import '../../data_sources/remote/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource remoteDataSource;
  NewsLocalDataSource newsLocalDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource, required this.newsLocalDataSource});

  @override
  Future<NewsResponse?> getNewsBySourceId(String sourceId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final hasConnection = connectivityResult.contains(
        ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);

    if (hasConnection) {
      try {
        var newsResponse = await remoteDataSource.getNewsBySourceId(sourceId);
        await newsLocalDataSource.saveNews(newsResponse, sourceId);
        return newsResponse;
      } catch (e) {
        return await newsLocalDataSource.getNewsBySourceId(sourceId);
      }
    } else {
      return await newsLocalDataSource.getNewsBySourceId(sourceId);
    }
  }

}
