import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotes getNotes;
  final CreateNote createNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NoteBloc({
    required this.getNotes,
    required this.createNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NoteInitial()) {
    on<GetNotesEvent>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
    on<CreateNoteEvent>((event, emit) async {
      emit(NoteLoading());
      try { 
 
        await createNote(event.note);
        add(GetNotesEvent());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
    on<UpdateNoteEvent>((event, emit) async {
      emit(NoteLoading());
      try {
        await updateNote(event.note);
        add(GetNotesEvent());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
    on<DeleteNoteEvent>((event, emit) async {
      emit(NoteLoading());
      try {
        await deleteNote(event.id);
        add(GetNotesEvent());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}