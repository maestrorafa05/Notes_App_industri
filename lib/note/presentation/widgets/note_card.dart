import 'package:flutter/material.dart';
import 'package:note/domain/entities/note.dart';
import '../pages/edit_note_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/note_bloc.dart';
 
class NoteCard extends StatelessWidget {
  final Note note;
  final int index;
  const NoteCard({Key? key, required this.note, required this.index})
    : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    // Color palette from the reference image
    final colors = [
      const Color(0xFFFFB59E), // orange
      const Color(0xFFFFE682), // yellow
      const Color(0xFFB5EAEA), // blue
      const Color(0xFFD9ACF5), // purple
      const Color(0xFFB6F7A1), // green
      const Color(0xFFFFB5E5), // pink
      const Color(0xFFF7F7B6), // light yellow
      const Color(0xFFB6E0F7), // light blue
    ];
    final cardColor = colors[index % colors.length];
 
    // Variable height for Masonry effect
    final minHeight = 110.0;
    final maxHeight = 180.0;
    final height = minHeight + (index % 3) * 35.0;
 
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          final noteBloc = context.read<NoteBloc>();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<NoteBloc>.value(
                value: noteBloc,
                child: EditNotePage(note: note),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(18),
          constraints: BoxConstraints(
            minHeight: minHeight,
            maxHeight: maxHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  _formatDate(note.createdAt),
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  String _formatDate(DateTime date) {
    // Example: Feb 01, 2020
    return "${_monthString(date.month)} ${date.day.toString().padLeft(2, '0')}, ${date.year}";
  }
 
  String _monthString(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}