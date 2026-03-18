import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/core/model/note_model.dart';
import 'package:note_flutteronline_97/features/create_note/logic/states.dart';
import 'package:note_flutteronline_97/features/home/presentation/screen/home_screen.dart';
import 'package:note_flutteronline_97/features/update_note/logic/cubit.dart';

import '../../../../core/widgets/app_txt_feild.dart';
import '../logic/state.dart';

class UpdateNoteScreen extends StatelessWidget {
  NoteModel noteDate;

  UpdateNoteScreen({super.key, required this.noteDate});

  final TextEditingController headlineController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateNoteCubit(),
      child: BlocConsumer<UpdateNoteCubit, UpdateNoteStates>(
        listener: (context, state) {
          if (state is UpdateNoteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Note Updated Successful"),
                duration: Duration(seconds: 3),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          } else if (state is UpdateNoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF14000F),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    const Text(
                      'Update Your Note',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Head line',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormFiledWidget(
                      controller: headlineController,
                      keyType: TextInputType.text,
                      hintTxt: noteDate.noteName,
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormFiledWidget(
                      controller: descriptionController,
                      hintTxt: noteDate.noteHeadline,
                      keyType: TextInputType.text,
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF3A2B33),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Select Media',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UpdateNoteCubit>().updateNote(
                            id: noteDate.noteId!,
                            updatedNote: NoteModel(
                              noteName: headlineController.text,
                              noteHeadline: descriptionController.text,
                              time: DateTime.now(),
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF3A2B33),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: (state is CreateNoteStatesLoadingState)
                            ? CircularProgressIndicator()
                            : Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
