import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../auth/login/presentation/screens/login.dart';
import '../../../create_note/presentation/screen/create_note_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButton(
          buttonWidth: 160,
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNewNoteScreen(),
              ),
            );
          },
          buttonTxt: "Add Note",
        ),
        AppButton(
          buttonWidth: 160,
          function: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          buttonTxt: "Logout",
        ),
      ],
    );

  }
}
