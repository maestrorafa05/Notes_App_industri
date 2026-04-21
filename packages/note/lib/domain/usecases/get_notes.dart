import '../repositories/note_repository.dart';
import '../entities/note.dart';

class GetNotes {
  final NoteRepository repository;
  GetNotes(this.repository);

  Future<List<Note>> call() {
    return repository.getNotes();
  }
} 