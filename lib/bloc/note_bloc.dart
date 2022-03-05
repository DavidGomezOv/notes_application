import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:notes_application/core/result.dart';
import 'package:notes_application/domain/note_use_case.dart';
import 'package:notes_application/models/note.dart';
import 'package:rxdart/rxdart.dart';

class NoteBloc {

  final NoteUseCase _noteUseCase;

  final _listSubject = BehaviorSubject<Result<List<Note>>>();
  ValueStream<Result<List<Note>>> get listNotes => _listSubject.stream;

  final _loadingSubject = BehaviorSubject<bool>();
  ValueStream<bool> get loading => _loadingSubject.stream;

  final _changeColorSubject = BehaviorSubject<Color>();
  ValueStream<Color> get changeColor => _changeColorSubject.stream;
  StreamSink<Color> get changeColorSink => _changeColorSubject.sink;

  final _changeListViewSubject = BehaviorSubject<bool>();
  ValueStream<bool> get changeListView => _changeListViewSubject.stream;
  StreamSink<bool> get changeListViewSink => _changeListViewSubject.sink;

  final _changeTextDataSubject = BehaviorSubject<bool>();
  ValueStream<bool> get changeTextData => _changeTextDataSubject.stream;
  StreamSink<bool> get changeTextDataSink => _changeTextDataSubject.sink;

  NoteBloc(this._noteUseCase);


  Future<Result<List<Note>>> getNotes() {
    _loadingSubject.add(true);
    return _noteUseCase.getNotes().then((value) {
      _loadingSubject.add(false);
      _listSubject.add(value);
      return value;
    }).catchError((error){
      _loadingSubject.add(false);
      _listSubject.add(Result(errorMsg: error.toString()));
    });
  }

  Future<Result<int>> saveOrEditNote(Note note, bool isSave) {
    _loadingSubject.add(true);
    return _noteUseCase.saveNote(note, isSave).then((value) {
      _loadingSubject.add(false);
      return value;
    });
  }

  Future<Result<bool>> deleteNote(Note note) {
    _loadingSubject.add(true);
    return _noteUseCase.deleteNote(note).then((value) {
      _loadingSubject.add(false);
      return value;
    });
  }

}