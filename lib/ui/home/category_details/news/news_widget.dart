import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/sources/source.dart';
import 'package:news/data/di/di.dart';
import 'package:news/ui/home/category_details/news/cubit/news_states.dart';
import 'package:news/ui/home/category_details/news/cubit/news_view_model.dart';
import 'package:news/ui/home/widget/main_error_widget.dart';
import 'package:news/ui/home/widget/main_loading_widget.dart';
import 'package:news/utils/size_utils.dart';

import '../../../../api/model/news/news.dart';
import '../../../../l10n/app_localizations.dart';
import 'new_item.dart';
import 'new_preview_helper.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key, required this.source});

  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final List<News> _newsList = [];
  final ScrollController _scrollController = ScrollController();
  NewsViewModel viewModel = NewsViewModel(
    newsRepository: injectNewsRepository(),
  );

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isFirstLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id!);
    _loadNews();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadNews();
    }
  }

  Future<void> _loadNews() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiManager.getNewsBySourceId(
        widget.source.id ?? '',
        page: _currentPage,
      );

      final newArticles = response.articles ?? [];

      setState(() {
        _newsList.addAll(newArticles);
        _currentPage++;
        _isLoadingMore = false;
        _isFirstLoading = false;
        if (newArticles.length < 20) {
          _hasMore = false;
        }
      });
    } catch (e, stackTrace) {
      print('NEWS LOADING ERROR: $e');
      print('STACK TRACE: $stackTrace');
      setState(() {
        _isLoadingMore = false;
        _isFirstLoading = false;
        _errorMessage = AppLocalizations.of(context)!.something_went_wrong;
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _newsList.clear();
      _currentPage = 1;
      _hasMore = true;
      _isFirstLoading = true;
    });
    await _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsViewModel, NewsStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return const MainLoadingWidget();
        }

        if (state is NewsErrorState) {
          return MainErrorWidget(
            errorMesaage: state.errorMessage ?? AppLocalizations.of(context)!.something_went_wrong,
            onPressed: () => viewModel.getNewsBySourceId(widget.source.id ?? ''),
          );
        }

        // نستخرج الليست والـ hasMore من أي state فيها بيانات
        List<News>? newsList;
        bool hasMore = false;

        if (state is NewsSuccessState) {
          newsList = state.newsList;
          hasMore = state.hasMore;
        } else if (state is NewsLoadingMoreState) {
          newsList = state.currentList;
          hasMore = true; // لسه بيحمّل صفحة جديدة
        }

        if (newsList == null || newsList.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.no_news,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => viewModel.refresh(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (hasMore &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                viewModel.loadMore();
              }
              return false;
            },
            child: ListView.separated(
              itemCount: newsList.length + (state is NewsLoadingMoreState ? 1 : 0),
              separatorBuilder: (context, index) =>
                  SizedBox(height: context.scaleHeight(10)),
              itemBuilder: (context, index) {
                if (index >= newsList!.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return GestureDetector(
                  onTap: () => showNewsPreview(context, newsList![index]),
                  child: NewsItem(news: newsList[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}


// );
