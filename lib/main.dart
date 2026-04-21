import 'package:core_services/supabase/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Tambahkan import ini
import 'injector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'note/presentation/pages/note_list_page.dart';
import 'note/presentation/bloc/note_bloc.dart'; // Sesuaikan path NoteBloc kamu

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  // Inisialisasi GetIt / Service Locator
  setupInjector(); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bungkus MaterialApp dengan MultiBlocProvider agar Bloc bisa diakses di semua halaman
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
          // Mengambil instance NoteBloc dari GetIt/Injector
          create: (context) => getIt<NoteBloc>(), 
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Practice Note App',
        theme: ThemeData(
          brightness: Brightness.dark, // Karena UI kamu bertema gelap
          primarySwatch: Colors.blue,
        ),
        home: const NoteListPage(),
      ),
    );
  }
}