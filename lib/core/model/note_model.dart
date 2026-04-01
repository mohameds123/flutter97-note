import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String noteName;
  String noteHeadline;
  DateTime time;
  String userId;
  String? noteId;
  String? imageUrl;

  NoteModel({
    required this.noteName,
    required this.noteHeadline,
    required this.time,
    required this.userId,
    this.noteId,
    this.imageUrl,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteName: json['noteName'],
      noteId: json['noteId'],
      userId: json['userId'],
      noteHeadline: json['noteHeadline'],
      imageUrl: json['imageUrl'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noteName': noteName,
      'noteHeadline': noteHeadline,
      'time': time.toIso8601String(),
      'userId': userId,
      'imageUrl': imageUrl,
    };
  }

  NoteModel copyWith({
    String? noteName,
    String? noteHeadline,
    DateTime? time,
    String? userId,
    String? noteId,
    String? imageUrl,
  }) {
    return NoteModel(
      noteName: noteName ?? this.noteName,
      noteHeadline: noteHeadline ?? this.noteHeadline,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      noteId: noteId ?? this.noteId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}