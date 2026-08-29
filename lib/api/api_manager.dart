import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/api/model/sources/source_response.dart';

class ApiManager {
  Future<SourceResponse> getSources(String categoryId) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
        'apiKey': ApiConstants.apiKey,
        'category': categoryId
      });

      var response = await http.get(url);
      var responseBody = response.body;

      ///String => json
      var json = jsonDecode(responseBody);

      ///json => object
      return SourceResponse.fromJson(json);
      //==> we can replace the above withe next line code
      // SourceResponse.fromJson(jsonDecode(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> searchNews(String query, {int page = 1}) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.apiKey,
        'q': query,
        'page': page.toString(),
        'pageSize': '20',
      });
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  Future<NewsResponse> getNewsBySourceId(String sourceId,
      {int page = 1}) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
        'apiKey': ApiConstants.apiKey,
        'sources': sourceId,
        'page': page.toString(),
        'pageSize': '20'

      });
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
