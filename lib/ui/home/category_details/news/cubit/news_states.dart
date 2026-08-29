import 'package:news/api/model/news/news.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsLoadingMoreState extends NewsStates {
  final List<News> currentList;

  NewsLoadingMoreState({required this.currentList});
}

class NewsErrorState extends NewsStates {
  String errorMessage;
  NewsErrorState({required this.errorMessage});
}

class NewsSuccessState extends NewsStates {
  List<News> newsList;
  bool hasMore;

  NewsSuccessState({required this.newsList, this.hasMore = true});
}