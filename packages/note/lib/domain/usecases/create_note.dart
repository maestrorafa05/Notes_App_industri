import '../repositories/note_repository.dart';
import '../entities/note.dart';

class CreateNote {
  final NoteRepository repository;
  CreateNote(this.repository);

  Future<void> call(Note note) {
    return repository.createNote(note);
  }
} 