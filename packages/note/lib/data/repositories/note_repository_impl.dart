import '../../domain/repositories/note_repository.dart';
import '../../domain/entities/note.dart';
import '../datasources/note_supabase_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteSupabaseDatasource datasource;
  NoteRepositoryImpl(this.datasource);

  @override
  Future<List<Note>> getNotes() async {
    return await datasource.getNotes();
  }

  @override
  Future<void> createNote(Note note) async {
    await datasource.createNote(note as NoteModel);
  }

  @override
  Future<void> updateNote(Note note) async { 
 
    await datasource.updateNote(note as NoteModel);
  }

  @override
  Future<void> deleteNote(String id) async {
    await datasource.deleteNote(id);
  }
} 