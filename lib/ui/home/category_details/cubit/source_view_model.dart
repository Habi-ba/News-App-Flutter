import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/data/repository/sources/repository/source_repository.dart';
import 'package:news/ui/home/category_details/cubit/source_states.dart';

@injectable //=> means making an initialize of an object of this class
class SourceViewModel extends Cubit<SourceStates> {
  SourceRepository sourceRepository;

  SourceViewModel({required this.sourceRepository})
    : super(SourceLoadingState());

  //todo:hold data - handle logic
  //List<Source>? sourcesList;
  // String? errorMessage;

  void getSources(String categoryId) async {
    try {
      //todo:loading
      emit(SourceLoadingState());
      //todo:call api
      var response = await sourceRepository.getSources(categoryId);
      if (response.status == 'error') {
        //todo:error
        emit(SourceErrorState(errorMessage: response.message!));
      }
      if (response.status == 'ok') {
        //todo:success

        emit(SourceSuccessState(sourcesList: response.source!));
      }
    } catch (e) {
      emit(SourceErrorState(errorMessage: e.toString()));
    }
  }
}
