import 'package:news/api/model/sources/source_response.dart';
import 'package:news/data/repository/sources/data_sources/local/source_local_data_source.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  Future<SourceResponse> getSources(String categoryId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }

  @override
  void saveSources(SourceResponse sourceResponse) {
    // TODO: implement saveSources
  }
}