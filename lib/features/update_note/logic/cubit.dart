import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/core/model/note_model.dart';
import 'package:note_flutteronline_97/features/update_note/logic/state.dart';

class UpdateNoteCubit extends Cubit <UpdateNoteStates> {
  UpdateNoteCubit () : super (UpdateNoteInitialState());

  Future updateNote ({required String id, required NoteModel updatedNote}) async {
    emit( UpdateNoteLoadingState());
    try {
      await FirebaseFirestore.instance.collection("notes").doc(id).update(updatedNote.toJson());
      emit(UpdateNoteSuccessState());

    }catch (e){
      emit(UpdateNoteErrorState(errorMessage: e.toString()));
    }
  }
}