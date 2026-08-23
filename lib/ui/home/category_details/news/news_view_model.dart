//todo:viewModel =>stateManagement
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/news/news.dart';

class NewsViewModel extends ChangeNotifier {
  //todo:hold data -handle logic
  List<News>? newsList;
  String? errorMessage;
  bool isLoading = false;

  void getNewsBySourceId(String sourceId) async {
    // //todo:reinitialize
    // newsList=null;
    // errorMessage=null;
    // isLoading=false;
    // notifyListeners();
    try {
      isLoading = true;
      var newsResponse = await ApiManager.getNewsBySourceId(sourceId);
      if (newsResponse.status == 'error') {
        isLoading = false;
        //todo:server => error
        errorMessage = newsResponse.message!;
      } else {
        isLoading = false;

        newsList = newsResponse.articles!;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
