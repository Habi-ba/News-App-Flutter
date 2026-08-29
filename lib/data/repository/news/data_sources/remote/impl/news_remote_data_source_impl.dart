import 'package:news/api/api_manager.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/data/repository/news/data_sources/remote/news_remote_data_source.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse> getNewsBySourceId(String sourceId, {int page = 1}) {
    return apiManager.getNewsBySourceId(sourceId, page: page);
  }
}

//todo:dio
class NewsRemoteDataSourceDio implements NewsRemoteDataSource {
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceID, {int page = 1}) {
    throw UnimplementedError();
  }
}

//todo:retrofit
class NewsRemoteDataSourceRetroFit implements NewsRemoteDataSource {
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceID, {int page = 1}) {
    throw UnimplementedError();
  }
}