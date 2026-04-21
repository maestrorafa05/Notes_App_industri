import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note_model.dart';
import 'package:core_services/core_services.dart';
class NoteSupabaseDatasource {
  final SupabaseClient client;
  NoteSupabaseDatasource(this.client);

  Future<List<NoteModel>> getNotes() async {
    final response = await client
        .from(SupabaseTables.notes)
        .select()
        .order('created_at', ascending: false);
    return (response as List)
        .map((json) => NoteModel.fromJson(json as Map<String,
dynamic>))
        .toList();
  }

  Future<void> createNote(NoteModel note) async { 
 
    await
client.from(SupabaseTables.notes).insert(note.toJson());
  }

  Future<void> updateNote(NoteModel note) async {
    await client
        .from(SupabaseTables.notes)
        .update(note.toJson())
        .eq('id', note.id);
  }

  Future<void> deleteNote(String id) async {
    await client.from(SupabaseTables.notes).delete().eq('id',
id);
  }
} 