import 'news.dart';

class NewsResponse {
  NewsResponse({
    this.message,
    this.code,
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsResponse.fromJson(dynamic json) {
    message = json['message'];
    code = json['code'];
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(News.fromJson(v));
      });
    }
  }

  String? status;
  int? totalResults;
  List<News>? articles;
  String? message;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['totalResults'] = totalResults;
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
