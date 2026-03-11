import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/features/create_note/data/note_model.dart';
import 'package:note_flutteronline_97/features/create_note/logic/states.dart';

class CreateNoteCubit extends Cubit <CreateNoteStates>{
  
  CreateNoteCubit () : super (CreateNoteStatesInitialState());
  
  Future createNote (NoteModel note) async {
    emit(CreateNoteStatesLoadingState());
    try{
     await FirebaseFirestore.instance.collection("notes").add(note.toJson());
     emit(CreateNoteStatesSuccessState());
    }catch (e){
      emit(CreateNoteStatesErrorState(errorMessage: e.toString()));
    }
  }
}