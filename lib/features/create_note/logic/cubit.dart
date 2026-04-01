import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_flutteronline_97/core/model/note_model.dart';
import 'package:note_flutteronline_97/core/service/cloudnairy_service.dart';
import 'package:note_flutteronline_97/features/create_note/logic/states.dart';

class CreateNoteCubit extends Cubit <CreateNoteStates>{
  
  CreateNoteCubit () : super (CreateNoteStatesInitialState());
  XFile? selectedImage;
  final CloudinaryService cloudinaryService = CloudinaryService();

  ImagePicker picker = ImagePicker();

  Future createNote (NoteModel note) async {
    emit(CreateNoteStatesLoadingState());
    try{
      String ? imageUrl;
      if (selectedImage != null){
        imageUrl = await cloudinaryService.uploadImage(File(selectedImage!.path));
      }
      final docRef = FirebaseFirestore.instance.collection("notes").doc();
      await docRef.set({
        ...note.toJson(),
        "imageUrl" : imageUrl,
      });

     emit(CreateNoteStatesSuccessState());
    }catch (e){
      emit(CreateNoteStatesErrorState(errorMessage: e.toString()));
    }
  }

  Future selectImageCamera () async {
    XFile ? image  = await picker.pickImage(source: ImageSource.camera);
    if (image != null ){
      selectedImage = image;
      emit (CreateNoteImagePickedState(image : image));
    }
  }
  Future selectImageGallery () async {
    XFile ? image  = await picker.pickImage(source: ImageSource.gallery);
    if (image != null ){
      selectedImage = image;
      emit (CreateNoteImagePickedState(image : image));
    }
  }
}