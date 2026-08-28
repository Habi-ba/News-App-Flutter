import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../api/model/news/news.dart';

class FullArticleScreen extends StatefulWidget {
  final News news;

  const FullArticleScreen({super.key, required this.news});

  @override
  State<FullArticleScreen> createState() => _FullArticleScreenState();
}

class _FullArticleScreenState extends State<FullArticleScreen> {
  bool _isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) => setState(() => _isLoading = true),
              onPageFinished: (_) => setState(() => _isLoading = false),
            ),
          )
          ..loadRequest(Uri.parse(widget.news.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.news.title!), centerTitle: true),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
