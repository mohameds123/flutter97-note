import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_flutteronline_97/features/auth/login/logic/state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  Future login({required String userEmail, required String userPass}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  Future continueWithGoogle() async {
    emit(LoginLoadingState());
    try {
      final GoogleSignInAccount? signIn = await GoogleSignIn().signIn();
      if (signIn == null) {
        emit(LoginErrorState(errorMessage: "continue with google is canceled"));
        return;
      }
      final GoogleSignInAuthentication googleSignIn =
          await signIn.authentication;

      final auth = GoogleAuthProvider.credential(
        accessToken: googleSignIn.accessToken,
        idToken: googleSignIn.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(auth);
      emit(LoginSuccessState());
    } catch (e) {
      print ("======== google error $e");
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
