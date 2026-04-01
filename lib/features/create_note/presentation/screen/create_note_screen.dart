import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_flutteronline_97/core/model/note_model.dart';
import 'package:note_flutteronline_97/core/utils/colors_manager.dart';
import 'package:note_flutteronline_97/features/create_note/logic/cubit.dart';
import 'package:note_flutteronline_97/features/create_note/logic/states.dart';
import 'package:note_flutteronline_97/features/home/presentation/screen/home_screen.dart';

import '../../../../core/widgets/app_txt_feild.dart';

class CreateNewNoteScreen extends StatefulWidget {
  CreateNewNoteScreen({super.key});

  @override
  State<CreateNewNoteScreen> createState() => _CreateNewNoteScreenState();
}

class _CreateNewNoteScreenState extends State<CreateNewNoteScreen> {
  final TextEditingController headlineController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  Future <String?> uploadImage () async {
    final location = FirebaseStorage.instance.ref().child("noteImage/");
    await location.putFile(File(context.read<CreateNoteCubit>().selectedImage!.path));
    return location.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => CreateNoteCubit(),
      child: BlocConsumer<CreateNoteCubit, CreateNoteStates>(
        listener: (context, state) {
          if (state is CreateNoteStatesSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Note Created Successful"),
                duration: Duration(seconds: 3),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          } else if (state is CreateNoteStatesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CreateNoteCubit>();
          return Scaffold(
            backgroundColor: const Color(0xFF14000F),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    const Text(
                      'Create New Note',
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
                      hintTxt: 'Enter Note Address',
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
                      hintTxt: 'Enter Your Description',
                      keyType: TextInputType.text,
                    ),
                    SizedBox(height: 16),
                    (cubit.selectedImage != null)
                        ? Center(
                            child: CircleAvatar(
                              maxRadius: screenHeight * 0.2,
                              backgroundColor: Colors.transparent,
                              backgroundImage: FileImage(
                                File(cubit.selectedImage!.path),
                              ),
                            ),
                          )
                        : SizedBox(),

                    SizedBox(
                      height: (cubit.selectedImage != null)
                          ? screenHeight * 0.02
                          : screenHeight * 0.4,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: Container(
                                  height: 140,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 160,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: ColorsManager.primary,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Camera",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          cubit.selectImageCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SizedBox(height: 12),
                                      InkWell(
                                        child: Container(
                                          width: 160,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: ColorsManager.primary,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Gallery",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          cubit.selectImageGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
                        onPressed: () async{
                          if(cubit.selectedImage != null){
                            final imageUrl = await uploadImage();
                            context.read<CreateNoteCubit>().createNote(
                              NoteModel(
                                imageUrl: imageUrl,
                                noteName: headlineController.text,
                                noteHeadline: descriptionController.text,
                                time: DateTime.now(),
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              ),
                            );
                          }else {
                            context.read<CreateNoteCubit>().createNote(
                              NoteModel(
                                noteName: headlineController.text,
                                noteHeadline: descriptionController.text,
                                time: DateTime.now(),
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              ),
                            );
                          }

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
                                'Create',
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
