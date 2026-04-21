part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class GetNotesEvent extends NoteEvent {}

class CreateNoteEvent extends NoteEvent {
  final Note note;
  const CreateNoteEvent(this.note);
 
 
  @override
  List<Object?> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;
  const UpdateNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String id;
  const DeleteNoteEvent(this.id);

  @override
  List<Object?> get props => [id];
} 