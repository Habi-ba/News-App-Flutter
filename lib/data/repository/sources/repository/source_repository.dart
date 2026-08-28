import 'package:news/api/model/sources/source_response.dart';

abstract class SourceRepository {
  Future<SourceResponse> getSources(String categoryId);
}