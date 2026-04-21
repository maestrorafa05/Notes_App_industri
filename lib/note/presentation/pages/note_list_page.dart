import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:practice_notes_app/note/presentation/pages/create_note_page.dart';
import '../bloc/note_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../injector.dart';
import '../widgets/note_card.dart';
 
class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);
 
  @override
  State<NoteListPage> createState() => _NoteListPageState();
}
 
class _NoteListPageState extends State<NoteListPage> {
  late NoteBloc _noteBloc;
  bool _initialized = false;
 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _noteBloc = getIt<NoteBloc>();
      _noteBloc.add(GetNotesEvent());
      _initialized = true;
    } else {
      _noteBloc.add(GetNotesEvent());
    }
  }
 
  @override
  void dispose() {
    _noteBloc.close();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>.value(
      value: _noteBloc,
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          Widget buildScaffold({required Widget body}) {
            return Scaffold(
              backgroundColor: const Color(0xFF181818),
              appBar: AppBar(
                backgroundColor: const Color(0xFF181818),
                elevation: 0,
                title: const Text(
                  'Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                centerTitle: false,
              ),
              body: body,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreateNotePage()),
                  );
                  // Refresh notes after returning from create page
                  _noteBloc.add(GetNotesEvent());
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
            );
          }
 
          if (state is NoteLoading) {
            return buildScaffold(
              body: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          } else if (state is NoteLoaded) {
            return buildScaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) =>
                      NoteCard(note: state.notes[index], index: index),
                ),
              ),
            );
          } else if (state is NoteError) {
            return buildScaffold(
              body: Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return buildScaffold(
            body: const Center(
              child: Text(
                'No notes found.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}