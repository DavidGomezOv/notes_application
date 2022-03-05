import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/models/note.dart';
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

  @override
  void initState() {
    super.initState();
    getPreferencesBool(AppSettings().isGridViewKey!).then((value) {
      isGridView = value;
    });
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
          child: Column(
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
                    },
                  ),
                  Expanded(
                      child: CustomGridNotes(
                    isGridView: isGridView,
                  ))
                ]
          ),
        ),
        floatingActionButton: ExpandableFab(
          children: [
            ActionButton(
              tag: 'create',
              icon: const Icon(Icons.create),
              onPressed: () { },
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
  final bool isGridView;

  const CustomGridNotes(
      {Key? key, required this.isGridView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Note> notesList = [];
    return Container(color: Colors.red,);
  }
}