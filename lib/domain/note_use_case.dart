import 'package:notes_application/core/result.dart';
import 'package:notes_application/models/note.dart';

mixin NoteUseCase {
  Future<Result<List<Note>>> getNotes();

  Future<Result<int>> saveNote(Note note, bool isSave);

  Future<Result<bool>> deleteNote(Note note);
}

mixin NoteRepository {
  Future<Result<List<Note>>> getNotes();

  Future<Result<int>> saveNote(Note note, bool isSave);

  Future<Result<bool>> deleteNote(Note note);
}


class NoteUseCaseImpl implements NoteUseCase {

  final NoteRepository _noteRepository;

  NoteUseCaseImpl(this._noteRepository);

  @override
  Future<Result<List<Note>>> getNotes() async {
    return await _noteRepository.getNotes().then((value) {
      if ((value.result != null && value.result!.isNotEmpty) || value.errorMsg != '') {
        return value;
      } else {
        return Result<List<Note>>(result: [], errorMsg: 'There are no notes');
      }
    });
  }

  @override
  Future<Result<int>> saveNote(Note note, bool isSave) async {
    if (validateFields(note)) {
      return await _noteRepository.saveNote(note, isSave);
    } else {
      return Result<int>(result: null, errorMsg: 'Data unavailable');
    }
  }

  @override
  Future<Result<bool>> deleteNote(Note note) {
    return _noteRepository.deleteNote(note);
  }

  bool validateFields(Note note) {
    final fields = [note.title, note.content, note.createdAt, note.color];
    for (int i = 0; i < fields.length; i++) {
      if (fields[i] == null || fields[i] == '') {
        return false;
      }
    }
    return true;
  }

}