import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  NewsViewModel viewModel = NewsViewModel(
    newsRepository: injectNewsRepository(),
  );

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id!);
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
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
            errorMesaage: state.errorMessage,
            onPressed: () => viewModel.getNewsBySourceId(widget.source.id ?? ''),
          );
        }

        List<News>? newsList;
        bool hasMore = false;
        bool isLoadingMore = false;

        if (state is NewsSuccessState) {
          newsList = state.newsList;
          hasMore = state.hasMore;
        } else if (state is NewsLoadingMoreState) {
          newsList = state.currentList;
          hasMore = true;
          isLoadingMore = true;
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
          onRefresh: () async => viewModel.refresh(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (hasMore &&
                  !isLoadingMore &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                viewModel.loadMore();
              }
              return false;
            },
            child: ListView.separated(
              itemCount: newsList.length + (isLoadingMore ? 1 : 0),
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