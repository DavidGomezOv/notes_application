import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_application/bloc/note_bloc.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/core/result.dart';
import 'package:notes_application/data/note_repository.dart';
import 'package:notes_application/domain/note_use_case.dart';
import 'package:notes_application/models/note.dart';
import 'package:notes_application/source/local/note_local_source.dart';
import 'package:notes_application/ui/create_note_page.dart';
import 'package:notes_application/utils/extension_functions.dart';
import 'package:notes_application/utils/ui_utils.dart';
import 'package:notes_application/widgets/custom_app_bar.dart';
import 'package:notes_application/widgets/custom_floating_action_button.dart';
import 'package:notes_application/widgets/custom_grid_tile.dart';
import 'package:notes_application/widgets/show_error_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controllerSearch = TextEditingController();

  bool isGridView = true;

  late NoteBloc _noteBloc;

  @override
  void initState() {
    super.initState();
    getPreferencesBool(AppSettings().isGridViewKey!).then((value) {
      isGridView = value;
      _noteBloc.changeListViewSink.add(isGridView);
    });
    _noteBloc =
        NoteBloc(NoteUseCaseImpl(NoteRepositoryImpl(NoteLocalSourceImpl())));
    _noteBloc.getNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0),
          color: HexColor.fromHex(AppSettings().colorBlack74),
          child: StreamBuilder<bool>(
            stream: _noteBloc.changeListView,
            initialData: isGridView,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                isGridView = snapshot.data!;
              }
              return Column(
                children: [
                  CustomAppBar(
                    textEditingController: _controllerSearch,
                    title: 'Search notes here',
                    textColor: HexColor.fromHex(AppSettings().colorWhite54),
                    iconData: Icon(
                      isGridView ? Icons.view_list : Icons.auto_awesome_mosaic,
                      size: 35.0,
                      color: HexColor.fromHex(AppSettings().colorWhite38),
                    ),
                    onTap: () {
                      isGridView = isGridView ? false : true;
                      savePreferencesBool(AppSettings().isGridViewKey!, isGridView);
                      _noteBloc.changeListViewSink.add(isGridView);
                    },
                  ),
                  Expanded(
                      child: CustomGridNotes(
                        noteBloc: _noteBloc,
                        isGridView: isGridView,
                      ))
                ],
              );
            },
          ),
        ),
        floatingActionButton: ExpandableFab(
          children: [
            ActionButton(
              tag: 'create',
              icon: const Icon(Icons.create),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNotePage(),
                    )).then((value) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (_, __, ___) => const HomePage(),
                    ),
                  );
                });
              },
            ),
            ActionButton(
              tag: 'photo',
              icon: const Icon(Icons.insert_photo),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGridNotes extends StatelessWidget {
  final NoteBloc noteBloc;
  final bool isGridView;

  const CustomGridNotes(
      {Key? key, required this.noteBloc, required this.isGridView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Note> notesList = [];
    return StreamBuilder<Result<List<Note>>>(
        stream: noteBloc.listNotes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Result<List<Note>>? resp = snapshot.data!;
            if (resp.errorMsg != '') {
              return ShowErrorScreen(
                errorMsg: resp.errorMsg,
                onRefresh: () async {
                  noteBloc.getNotes();
                  return Future.value(null);
                },
              );
            } else {
              notesList = resp.result!;
              return isGridView
                  ? StaggeredGridView.countBuilder(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 4,
                  itemCount: notesList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      CustomGridTile(
                        note: notesList[index],
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNotePage(
                                note: notesList[index],
                              ),
                            )).then((value) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration.zero,
                              pageBuilder: (_, __, ___) => const HomePage(),
                            ),
                          );
                        }),
                      ),
                  staggeredTileBuilder: (int index) =>
                  const StaggeredTile.fit(2),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0)
                  : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: notesList.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: CustomGridTile(
                    note: notesList[index],
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNotePage(
                            note: notesList[index],
                          ),
                        )).then((value) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder: (_, __, ___) => const HomePage(),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}