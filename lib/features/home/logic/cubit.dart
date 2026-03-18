import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/core/model/note_model.dart';
import 'package:note_flutteronline_97/features/home/logic/state.dart';

class GetHomeDataCubit extends Cubit<GetHomeDataStates> {
  GetHomeDataCubit() : super(GetHomeDataInitialState());
  List<NoteModel> notes = [];

  Future getHomeData() async {
    emit(GetHomeDataLoadingState());
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      final response = await FirebaseFirestore.instance
          .collection("notes")
          .where("userId", isEqualTo: userId)
          .get();
      final finalResult = response.docs.map((doc) {
        return NoteModel.fromJson({...doc.data(), "noteId": doc.id});
      }).toList();
      notes = finalResult;

      emit(GetHomeDataSuccessState(noteModel: finalResult));
    } catch (e) {
      emit(GetHomeDataErrorState(errorMessage: e.toString()));
    }
  }

  ///==== DELETE NOTE FUNCTION====\\\
  Future deleteNote(String id) async {
    try {
       await FirebaseFirestore.instance.collection("notes").doc(id).delete();
      notes.removeWhere((note)=> note.noteId == id);

      emit(GetHomeDataSuccessState(noteModel: notes));

    } catch (e) {
      emit(DeleteNoteError(errorMessage: e.toString()));
    }
  }
}
