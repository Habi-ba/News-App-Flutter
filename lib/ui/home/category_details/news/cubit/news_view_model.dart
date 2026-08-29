import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/ui/home/category_details/news/cubit/news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  late NewsRepository newsRepository;

  NewsViewModel({required this.newsRepository}) : super(NewsLoadingState());

  //todo:hold data _handle Logic
  void getNewsBySourceId(String sourceId) async {
    try {
      emit(NewsLoadingState());
      var response = await newsRepository.getNewsBySourceId(sourceId);

      if (response == null) {
        emit(NewsErrorState(
            errorMessage: 'No Internet Connection ,Please Check Your Network'));
        return;
      }

      if (response.status == 'error') {
        emit(NewsErrorState(
            errorMessage: response.message ?? 'Unexpected Error Has Occurred'));
      } else if (response.status == 'ok') {
        emit(NewsSuccessState(newsList: response.articles ?? []));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}
