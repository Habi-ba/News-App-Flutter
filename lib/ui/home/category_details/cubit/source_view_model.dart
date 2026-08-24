import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/ui/home/category_details/cubit/source_states.dart';

class SourceViewModel extends Cubit<SourceStates> {
  SourceViewModel() : super(SourceLoadingState());

  //todo:hold data - handle logic
  //List<Source>? sourcesList;
  // String? errorMessage;

  void getSources(String categoryId) async {
    try {
      //todo:loading
      emit(SourceLoadingState());
      //todo:call api
      var response = await ApiManager.getSources(categoryId);
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
