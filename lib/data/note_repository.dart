import 'package:notes_application/core/result.dart';
import 'package:notes_application/domain/note_use_case.dart';
import 'package:notes_application/models/note.dart';

mixin NoteLocalSource {
  Future<Result<List<Note>>> getNotes();

  Future<Result<int>> saveNote(Note note, bool isSave);

  Future<Result<bool>> deleteNote(Note note);
}


class NoteRepositoryImpl implements NoteRepository {

  final NoteLocalSource _noteLocalSource;

  NoteRepositoryImpl(this._noteLocalSource);

  @override
  Future<Result<List<Note>>> getNotes() {
    return _noteLocalSource.getNotes();
  }

  @override
  Future<Result<int>> saveNote(Note note, bool isSave) {
    return _noteLocalSource.saveNote(note, isSave);
  }

  @override
  Future<Result<bool>> deleteNote(Note note) {
    return _noteLocalSource.deleteNote(note);
  }

}