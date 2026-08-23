import 'package:dio/dio.dart';
import 'package:news/api/end_points.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/api/model/sources/source_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// https://newsapi.org/v2/top-headlines?country=us&apiKey=c5a0b85348ff47fdbbf825d16ce0a026
class DioManager {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/',
      // queryParameters: {
      //   'apikey':ApiConstants.apiKey
      // }
      // headers: {
      //   'X-Api-Key':ApiConstants.apiKey
      // }
    ),
  ); // ..interceptors.add(PrettyDioLogger(
  //       requestHeader: true,
  //       requestBody: true,
  //       responseBody: true,
  //       responseHeader: false,
  //       error: true,
  //
  //
  //   )
  //do it in the constructor also
  DioManager() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );
  }

  Future<SourceResponse> getSources(String categoryId) async {
    try {
      var response = await dio.get(
        EndPoints.sourceApi,
        queryParameters: {'category': categoryId},
      );
      return SourceResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // https://newsapi.org/v2/everything?q=bitcoin&apiKey=c5a0b85348ff47fdbbf825d16ce0a026
  Future<NewsResponse> getNewsBySourceId(String sourceId) async {
    try {
      var response = await dio.get(
        EndPoints.newsApi,
        queryParameters: {'sources': sourceId},
      );
      return NewsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
