import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/api/model/news/news_response.dart';
import 'package:news/api/model/sources/source.dart';
import 'package:news/ui/home/widget/main_error_widget.dart';
import 'package:news/ui/home/widget/main_loading_widget.dart';
import 'package:news/utils/size_utils.dart';

import 'new_item.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key, required this.source});

  final Source source;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
      builder: (context, snapshot) {
        print('STATE = ${snapshot.connectionState}');
        print('ERROR = ${snapshot.error}');
        print('DATA = ${snapshot.data}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        } else if (snapshot.hasError) {
          return MainErrorWidget(
            errorMesaage: 'Something Went Wrong',
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '');
              setState(() {});
            },
          );
        } else if (snapshot.data!.status != 'ok') {
          return MainErrorWidget(
            errorMesaage: snapshot.data?.message ?? 'Something Went Wrong',
            onPressed: () {
              ApiManager.getNewsBySourceId(widget.source.id ?? '');
              setState(() {});
            },
          );
        } else {
          print('STATUS = ${snapshot.data?.status}');
          print('TOTAL = ${snapshot.data?.totalResults}');
          print('ARTICLES = ${snapshot.data?.articles?.length}');
          var newsList = snapshot.data!.articles ?? [];
          return newsList.isEmpty
              ? Center(
                child: Text(
                  'No News Found !',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
              )
              : ListView.separated(
                itemBuilder: (context, index) {
                  return NewsItem(
                    news: newsList[index],
                  );
                },
                itemCount: newsList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: context.scaleHeight(10));
                },
              );
        }
      },
    );
  }
}
