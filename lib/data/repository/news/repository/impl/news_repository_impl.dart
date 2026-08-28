import 'package:news/api/model/news/news_response.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';

import '../../data_sources/remote/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<NewsResponse> getNewsBySourceId(String sourceID) {
    return remoteDataSource.getNewsBySourceId(sourceID);
  }
}
