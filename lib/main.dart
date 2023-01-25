import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/models/note.dart';
import 'package:notes_application/ui/home_page.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  AppSettings().notesBox = 'NOTES';
  AppSettings().isGridViewKey = 'GRIDVIEW';
  AppSettings().indexCountKey = 'INDEX';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Notes Application',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
