import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/model/news/news.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/ui/home/category_details/news/cubit/news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  late NewsRepository newsRepository;

  NewsViewModel({required this.newsRepository}) : super(NewsLoadingState());

  final List<News> _newsList = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  String? _sourceId;

  static const int _pageSize = 20;


  void getNewsBySourceId(String sourceId) async {
    _sourceId = sourceId;
    _newsList.clear();
    _currentPage = 1;
    _hasMore = true;

    emit(NewsLoadingState());
    await _fetchPage();
  }

  // تحميل صفحة إضافية (infinite scroll)
  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    emit(NewsLoadingMoreState(currentList: List.from(_newsList)));
    await _fetchPage();
  }

  Future<void> _fetchPage() async {
    _isLoading = true;
    try {
      var response = await newsRepository.getNewsBySourceId(
        _sourceId ?? '',
        page: _currentPage,
      );

      if (response == null) {
        _isLoading = false;
        emit(NewsErrorState(
            errorMessage: 'No Internet Connection ,Please Check Your Network'));
        return;
      }

      if (response.status == 'error') {
        _isLoading = false;
        emit(NewsErrorState(
            errorMessage: response.message ?? 'Unexpected Error Has Occurred'));
        return;
      }

      final newArticles = response.articles ?? [];
      _newsList.addAll(newArticles);
      _currentPage++;
      _hasMore = newArticles.length >= _pageSize;
      _isLoading = false;

      emit(NewsSuccessState(newsList: List.from(_newsList), hasMore: _hasMore));
    } catch (e) {
      _isLoading = false;
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> refresh() async {
    getNewsBySourceId(_sourceId ?? '');
  }
}