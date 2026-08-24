import '../../../../api/model/sources/source.dart';

abstract class SourceStates {}

class SourceInitialState extends SourceStates {}

class SourceLoadingState extends SourceStates {}

class SourceErrorState extends SourceStates {
  String errorMessage;

  SourceErrorState({required this.errorMessage});
}

class SourceSuccessState extends SourceStates {
  List<Source> sourcesList;

  SourceSuccessState({required this.sourcesList});
}
