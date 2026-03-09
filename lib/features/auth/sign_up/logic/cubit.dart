import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/features/auth/sign_up/logic/state.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  Future signUp({required String userEmail, required String userPass}) async {
    emit(SignUpLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpErrorState(errorMessage: e.toString()));
    }
  }
}
