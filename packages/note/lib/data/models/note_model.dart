import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    String? id,
    required String title,
    required String content,
    required DateTime createdAt,
  }) : super(
         id: id ?? '',
         title: title,
         content: content,
         createdAt: createdAt,
       );

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String, 
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
    if (id.isNotEmpty) {
      map['id'] = id;
    }
    return map;
  }
} 