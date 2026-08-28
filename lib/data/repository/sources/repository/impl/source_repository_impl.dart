import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news/api/model/sources/source_response.dart';
import 'package:news/data/repository/sources/data_sources/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';

//for the injectable annotation
//we do it in this way bec we dont want to create a direct  object of this class
//we need it to be as an object of SourceRepository but we cant do it bec its abstract
//so we can do an object for on of its concrete classes like this

@Injectable(as: SourceRepository)
class SourceRepositoryImpl implements SourceRepository{
  SourceLocalDataSource localDataSource;
  SourceRemoteDataSource remoteDataSource;

  SourceRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<SourceResponse> getSources(String categoryId) async {
    //todo:internet=>remote ds
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //todo:internet=>remote ds
      //todo:get sources by using  remote ds

      var sourceResponse = await remoteDataSource.getSources(categoryId);
      //todo:save response
      localDataSource.saveSources(sourceResponse);
      return sourceResponse;
    } else {
      //todo:no Internet=> local ds
      //todo:get sources by using  local ds
      var sourceResponse = await localDataSource.getSources(categoryId);
      return sourceResponse;
    }


  }}