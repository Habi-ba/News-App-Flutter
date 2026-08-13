import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/end_points.dart';
import 'package:news/api/model/sources/source_response.dart';

//https://newsapi.org/v2/top-headlines/sources?apiKey=
// c5a0b85348ff47fdbbf825d16ce0a026
class ApiManager {
  static Future<SourceResponse> getSources() async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
        'apiKey': ApiConstants.apiKey,
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
}
