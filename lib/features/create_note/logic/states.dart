class CreateNoteStates {}

class CreateNoteStatesInitialState extends CreateNoteStates {}

class CreateNoteStatesLoadingState extends CreateNoteStates {}

class CreateNoteStatesSuccessState extends CreateNoteStates {}

class CreateNoteStatesErrorState extends CreateNoteStates {
  final String errorMessage;
  CreateNoteStatesErrorState({required this.errorMessage});
}