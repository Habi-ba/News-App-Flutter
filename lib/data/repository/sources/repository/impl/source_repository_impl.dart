import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/api/model/sources/source_response.dart';
import 'package:news/data/repository/sources/data_sources/local/source_local_data_source.dart';
import 'package:news/data/repository/sources/data_sources/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';

class SourceRepositoryImpl implements SourceRepository{
  SourceLocalDataSource localDataSource;
  SourceRemoteDataSource remoteDataSource;

  SourceRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final hasConnection = connectivityResult.contains(
        ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);

    if (hasConnection) {
      try {
        var sourceResponse = await remoteDataSource.getSources(categoryId);
        await localDataSource.saveSources(sourceResponse, categoryId);
        return sourceResponse;
      } catch (e) {
        return await localDataSource.getSources(categoryId);
      }
    } else {
      return await localDataSource.getSources(categoryId);
    }
  }

}