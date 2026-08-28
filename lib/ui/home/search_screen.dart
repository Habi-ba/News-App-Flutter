import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/utils/size_utils.dart';

import '../../../api/model/news/news.dart';
import 'category_details/news/full_article_screen.dart';
import 'category_details/news/new_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
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
        _errorMessage = 'Something Went Wrong';
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
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: context.scaleHeight(12)),
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _clearSearch,
                        )
                        : null,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: context.scaleHeight(16)),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (!_isSearched) {
      return Center(
        child: Text(
          'Search for news articles',
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
          'No results found',
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullArticleScreen(news: article),
              ),
            );
          },
          child: NewsItem(news: article),
        );
      },
    );
  }
}
