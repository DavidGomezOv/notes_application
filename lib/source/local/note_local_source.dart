import 'package:hive/hive.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/core/result.dart';
import 'package:notes_application/data/note_repository.dart';
import 'package:notes_application/models/note.dart';

class NoteLocalSourceImpl implements NoteLocalSource {

  @override
  Future<Result<List<Note>>> getNotes() async {
    List<Note> notes = [];
    final box = await Hive.openBox<Note>(AppSettings().notesBox!);
    for (var element in box.values) {
      //if (element is Note) print('nota ${element.index}, ${element.createdAt}, ${element.color}, ${element.content}');
      notes.add(element);
    }
    return Result<List<Note>>(result: notes);
  }

  @override
  Future<Result<int>> saveNote(Note note, bool isSave) async {
    final box = await Hive.openBox<Note>(AppSettings().notesBox!);
    await box.put(note.index, note);
    Note? resp = await box.get(note.index);
    return Result<int>(result: resp?.index ?? -1);
  }

  @override
  Future<Result<bool>> deleteNote(Note note) async {
    final box = Hive.box<Note>(AppSettings().notesBox!);
    await note.delete();
    bool resp = box.get(note.createdAt.toString()) == null;
    return Result<bool>(result: resp);
  }

}