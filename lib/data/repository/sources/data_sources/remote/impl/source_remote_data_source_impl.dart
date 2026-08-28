import 'package:injectable/injectable.dart';
import 'package:news/api/model/sources/source_response.dart';
import 'package:news/data/repository/sources/data_sources/remote/source_remote_data_source.dart';

import '../../../../../../api/api_manager.dart';

@Injectable(as: SourceRemoteDataSource)
class SourceRemoteDataSourceImpl implements SourceRemoteDataSource{
  ApiManager apiManager;
  SourceRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<SourceResponse> getSources(String categoryId) async{
    var response=await apiManager.getSources(categoryId);
    return response;

  }
}