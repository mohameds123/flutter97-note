import 'package:note_flutteronline_97/core/model/note_model.dart';

class GetHomeDataStates {}

class GetHomeDataInitialState extends GetHomeDataStates {}

class GetHomeDataLoadingState extends GetHomeDataStates {}

class GetHomeDataSuccessState extends GetHomeDataStates {
  List<NoteModel> noteModel;

  GetHomeDataSuccessState({required this.noteModel});
}

class GetHomeDataErrorState extends GetHomeDataStates {
  final String errorMessage;

  GetHomeDataErrorState({required this.errorMessage});
}

/// ======== delete states =========\\\\
///
class DeleteNoteLoading extends GetHomeDataStates {}

class DeleteNoteSuccess extends GetHomeDataStates {}

class DeleteNoteError extends GetHomeDataStates {
  final String errorMessage;

  DeleteNoteError({required this.errorMessage});
}
