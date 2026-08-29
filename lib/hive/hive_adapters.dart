import 'package:hive_ce/hive_ce.dart';
import 'package:news/api/model/news/news.dart';
import 'package:news/api/model/news/news_response.dart';

import '../api/model/sources/source.dart';

@GenerateAdapters([
  AdapterSpec<News>(),
  AdapterSpec<NewsResponse>(),
], firstTypeId: 3)
part 'hive_adapters.g.dart';
