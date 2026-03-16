import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String noteName;
  String noteHeadline;
  DateTime time;
  String userId;

  NoteModel({
    required this.noteName,
    required this.noteHeadline,
    required this.time,
    required this.userId,
  });

  // Convert Firestore document → Dart object
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteName: json['noteName'],
      userId: json['userId'],
      noteHeadline: json['noteHeadline'],
      time: DateTime.parse(json['time'])
    );
  }

  // Convert Dart object → Firestore document
  Map<String, dynamic> toJson() {
    return {
      'noteName': noteName,
      'noteHeadline': noteHeadline,
      'time': time.toIso8601String(),
      'userId': userId,
    };
  }
}
