import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/utils/size_utils.dart';

import '../../../api/model/news/news.dart';
import 'category_details/news/new_item.dart';
import 'category_details/news/new_preview_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  //used to manage user input time
  //if timer is not initialized , every letter will act to be a new request
  Timer? _debounce;

  List<News> _results = [];
  bool _isLoading = false;
  bool _isSearched = false;
  String? _errorMessage;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isEmpty) {
        setState(() {
          _results = [];
          _isSearched = false;
        });
        return;
      }
      _performSearch(query.trim());
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _isSearched = true;
    });

    try {
      final response = await ApiManager.searchNews(query);
      setState(() {
        _results = response.articles ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = AppLocalizations.of(context)!.something_went_wrong;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _results = [];
      _isSearched = false;
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: context.scaleHeight(16)),

                Center(
                  child: Text(
                    AppLocalizations.of(context)!.search,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                SizedBox(height: context.scaleHeight(16)),

                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search,
                    hintStyle: Theme.of(context).textTheme.headlineSmall,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onPressed: _clearSearch,
                            )
                            : null,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: context.scaleHeight(16),
                      horizontal: context.scaleWidth(15),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: context.scaleHeight(16)),

                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (!_isSearched) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.search_for_news_articles,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_results.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_news,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder:
          (context, index) => SizedBox(height: context.scaleHeight(10)),
      itemBuilder: (context, index) {
        final article = _results[index];
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            showNewsPreview(context, article);
          },
          child: NewsItem(news: article),
        );
      },
    );
  }
}