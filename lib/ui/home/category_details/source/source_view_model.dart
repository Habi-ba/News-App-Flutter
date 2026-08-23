//todo:viewModel =>stateManagement
import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/sources/source.dart';

class SourceViewModel extends ChangeNotifier {
  //todo:hold data -handle logic
  List<Source>? sourcesList;
  String? errorMessage;
  bool isLoading = false;

  void getSources(String categoryId) async {
    //todo:reinitialize
    sourcesList = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
    try {
      isLoading = true;
      var sourceResponse = await ApiManager.getSources(categoryId);
      if (sourceResponse.status == 'error') {
        isLoading = false;
        //todo:server => error
        errorMessage = sourceResponse.message!;
      } else {
        isLoading = false;

        sourcesList = sourceResponse.source;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
