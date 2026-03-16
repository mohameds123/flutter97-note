import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/core/model/note_model.dart';
import 'package:note_flutteronline_97/features/home/logic/state.dart';

class GetHomeDataCubit extends Cubit<GetHomeDataStates> {
  GetHomeDataCubit() : super(GetHomeDataInitialState());

  Future getHomeData() async {
    emit(GetHomeDataLoadingState());
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      final response = await FirebaseFirestore.instance
          .collection("notes")
          .where("userId", isEqualTo: userId)
          .get();
      final finalResult = response.docs.map((doc) {
        return NoteModel.fromJson(doc.data());
      }).toList();
      emit(GetHomeDataSuccessState(noteModel: finalResult));
    } catch (e) {
      emit(GetHomeDataErrorState(errorMessage: e.toString()));
    }
  }
}
