import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/sources/source.dart';
import 'package:news/ui/home/widget/main_error_widget.dart';
import 'package:news/ui/home/widget/main_loading_widget.dart';
import 'package:news/utils/size_utils.dart';

import '../../../../api/model/news/news.dart';
import 'full_article_screen.dart';
import 'new_item.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key, required this.source});

  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final List<News> _newsList = [];
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isFirstLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
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
        _errorMessage = 'Something Went Wrong';
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
    if (_isFirstLoading) {
      return const MainLoadingWidget();
    }

    if (_errorMessage != null && _newsList.isEmpty) {
      return MainErrorWidget(
        errorMesaage: _errorMessage!,
        onPressed: _refresh,
      );
    }

    if (_newsList.isEmpty) {
      return Center(
        child: Text(
          'No News Found !',
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: _newsList.length + (_hasMore ? 1 : 0),
        separatorBuilder: (context, index) =>
            SizedBox(height: context.scaleHeight(10)),
        itemBuilder: (context, index) {
          if (index >= _newsList.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return GestureDetector(
            onTap: () => _showPreview(context, _newsList[index]),
            child: NewsItem(news: _newsList[index]),
          );
        },
      ),
    );
  }

  void _showPreview(BuildContext context, News article) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //constraints: BoxConstraints(),
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(14),
            vertical: context.scaleHeight(14),
          ),
          //padding: EdgeInsets.all(context.scaleWidth(15)),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .dividerColor,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child:
                  article.urlToImage != null
                      ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.fill,
                    errorBuilder:
                        (context, error, stackTrace) =>
                        Container(
                          height: 180,
                          color: Colors.grey[800],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white54,
                          ),
                        ),
                  )
                      : Container(
                    height: 180,
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    article.description ?? 'No description available',
                    style: Theme
                        .of(context)
                        .textTheme
                        .displaySmall,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: context.scaleHeight(56),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullArticleScreen(news: article),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                        backgroundColor: Theme
                            .of(context)
                            .cardColor,
                      ),
                      child: Text(
                        "View Full Article",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
// );
