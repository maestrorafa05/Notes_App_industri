import 'package:get_it/get_it.dart';
import 'package:note/note.dart';
import 'package:core_services/core_services.dart';
import 'note/presentation/bloc/note_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Tambahkan jika perlu

final getIt = GetIt.instance;

void setupInjector() {
  // Ambil instance supabase yang sudah di-init di main
  final supabase = Supabase.instance.client;

  // Register repository and datasource
  getIt.registerLazySingleton<NoteSupabaseDatasource>( 
    () => NoteSupabaseDatasource(supabase),
  );
  
  // Gunakan Interface/Abstract class jika ada (NoteRepository)
  // Tapi jika NoteRepositoryImpl adalah class utama, kodenya sudah benar:
  getIt.registerLazySingleton<NoteRepositoryImpl>(
    () => NoteRepositoryImpl(getIt<NoteSupabaseDatasource>()),
  );

  // Register usecases
  getIt.registerLazySingleton(() => GetNotes(getIt<NoteRepositoryImpl>()));
  getIt.registerLazySingleton(() => CreateNote(getIt<NoteRepositoryImpl>()));
  getIt.registerLazySingleton(() => UpdateNote(getIt<NoteRepositoryImpl>()));
  getIt.registerLazySingleton(() => DeleteNote(getIt<NoteRepositoryImpl>()));

  // Register NoteBloc factory
  getIt.registerFactory<NoteBloc>(
    () => NoteBloc(
      getNotes: getIt<GetNotes>(),
      createNote: getIt<CreateNote>(),
      updateNote: getIt<UpdateNote>(),
      deleteNote: getIt<DeleteNote>(),
    ),
  );
}