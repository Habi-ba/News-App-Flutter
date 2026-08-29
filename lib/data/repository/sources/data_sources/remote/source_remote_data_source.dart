import 'package:news/api/model/sources/source_response.dart';

abstract class SourceRemoteDataSource {

  Future<SourceResponse>getSources(String categoryId);
}