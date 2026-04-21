import '../repositories/note_repository.dart';
import '../entities/note.dart';

class UpdateNote {
  final NoteRepository repository;
  UpdateNote(this.repository);

  Future<void> call(Note note) {
    return repository.updateNote(note);
  }
} 