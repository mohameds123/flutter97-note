import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String noteName;
  String noteHeadline;
  Timestamp time;

  NoteModel({
    required this.noteName,
    required this.noteHeadline,
    required this.time,
  });

  // Convert Firestore document → Dart object
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteName: json['noteName'],
      noteHeadline: json['noteHeadline'],
      time: json['time'],
    );
  }

  // Convert Dart object → Firestore document
  Map<String, dynamic> toJson() {
    return {
      'noteName': noteName,
      'noteHeadline': noteHeadline,
      'time': time,
    };
  }
}
