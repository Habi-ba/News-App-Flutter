import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';
import 'package:news/ui/home/category_details/cubit/source_states.dart';

class SourceViewModel extends Cubit<SourceStates> {
  SourceRepository sourceRepository;

  SourceViewModel({required this.sourceRepository})
    : super(SourceLoadingState());

  //todo:hold data - handle logic
  //List<Source>? sourcesList;
  // String? errorMessage;

  void getSources(String categoryId) async {
    try {
      emit(SourceLoadingState());
      var response = await sourceRepository.getSources(categoryId);

      if (response == null) {
        emit(SourceErrorState(
            errorMessage: 'No internet connection and no cached data available'));
        return;
      }

      if (response.status == 'error') {
        emit(SourceErrorState(
            errorMessage: response.message ?? 'Unexpected Error Has Occurred'));
      } else if (response.status == 'ok') {
        emit(SourceSuccessState(sourcesList: response.source ?? []));
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }
}
