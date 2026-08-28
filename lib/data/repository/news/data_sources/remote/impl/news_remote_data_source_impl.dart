import 'package:injectable/injectable.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/data/repository/news/data_sources/remote/news_remote_data_source.dart';

@Injectable(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse> getNewsBySourceId(String sourceId) {
    return apiManager.getNewsBySourceId(sourceId);
  }
}

//todo:dio
class NewsRemoteDataSourceDio implements NewsRemoteDataSource {
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceID) {
    // TODO: implement getNewsBySourceId
    throw UnimplementedError();
  }
}

//todo:retrofit
class NewsRemoteDataSourceRetroFit implements NewsRemoteDataSource {
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceID) {
    // TODO: implement getNewsBySourceId
    throw UnimplementedError();
  }
}
