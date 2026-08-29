import 'package:news/api/model/sources/source_response.dart';

abstract class SourceLocalDataSource {
  Future<SourceResponse?> getSources(String categoryId);

  Future<void> saveSources(SourceResponse sourceResponse, String categoryId);
}