import 'package:hive_ce/hive_ce.dart';
import 'package:news/api/model/sources/source_response.dart';
import 'package:news/data/repository/sources/data_sources/local/source_local_data_source.dart';

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var box = await Hive.openBox('Sources');
    var response = box.get(categoryId) as SourceResponse?;
    return response;
  }

  @override
  Future<void> saveSources(SourceResponse sourceResponse,
      String categoryId) async {
    //todo:open box
    var box = await Hive.openBox('Sources');
    //todo:save
    await box.put(categoryId, sourceResponse);
  }
}