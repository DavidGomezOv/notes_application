import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_application/bloc/note_bloc.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/core/text_type.dart';
import 'package:notes_application/data/note_repository.dart';
import 'package:notes_application/domain/note_use_case.dart';
import 'package:notes_application/models/note.dart';
import 'package:notes_application/source/local/note_local_source.dart';
import 'package:notes_application/utils/extension_functions.dart';
import 'package:notes_application/utils/ui_utils.dart';
import 'package:notes_application/widgets/custom_color_picker.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _controllerTitle = TextEditingController();
  final _controllerNote = TextEditingController();

  late String _createdDate;
  late Color _noteColor;
  late bool _isPinned;
  late TextType _textType;
  late int _textSize;

  late NoteBloc _noteBloc;

  @override
  void initState() {
    super.initState();
    _noteBloc =
        NoteBloc(NoteUseCaseImpl(NoteRepositoryImpl(NoteLocalSourceImpl())));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      _showNote();
    } else {
      _createdDate =
          DateFormat('MMM d, yyyy - h:mm aaa').format(DateTime.now());
      _noteColor = HexColor.fromHex(AppSettings().colorBlack74);
      _isPinned = false;
      _textType = TextType.normal;
      _textSize = 18;
    }
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: StreamBuilder<Color>(
          stream: _noteBloc.changeColor,
          initialData: _noteColor,
          builder: (context, snapshot) {
            if (snapshot.hasData) _noteColor = snapshot.data!;
            return Container(
              color: _noteColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: TextField(
                              controller: _controllerTitle,
                              decoration: const InputDecoration.collapsed(
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.push_pin,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            widget.note?.isPinned =
                                widget.note!.isPinned ? true : false;
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: _noteBloc.changeTextData,
                    initialData: false,
                    builder: (context, snapshot) {
                      final FontStyle txtStyle;
                      final FontWeight txtWeight;
                      if (_textType == TextType.italicBold) {
                        txtStyle = FontStyle.italic;
                        txtWeight = FontWeight.bold;
                      } else if (_textType == TextType.italic) {
                        txtStyle = FontStyle.italic;
                        txtWeight = FontWeight.normal;
                      } else if (_textType == TextType.bold) {
                        txtStyle = FontStyle.normal;
                        txtWeight = FontWeight.bold;
                      } else {
                        txtStyle = FontStyle.normal;
                        txtWeight = FontWeight.normal;
                      }
                      return Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: TextField(
                          controller: _controllerNote,
                          decoration: InputDecoration.collapsed(
                              hintText: 'Note',
                              hintStyle: TextStyle(
                                  fontSize: _textSize.toDouble(),
                                  color: Colors.white)),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: _textSize.toDouble(),
                              fontStyle: txtStyle,
                              fontWeight: txtWeight),
                          cursorColor: Colors.white,
                          maxLines: null,
                          expands: true,
                        ),
                      ));
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 145,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            child: const Text(
                              'B',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_textType == TextType.bold) {
                                _textType = TextType.normal;
                              } else if (_textType == TextType.italic) {
                                _textType = TextType.italicBold;
                              } else if (_textType == TextType.italicBold) {
                                _textType = TextType.italic;
                              } else {
                                _textType = TextType.bold;
                              }
                              _noteBloc.changeTextDataSink.add(true);
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          TextButton(
                            child: const FaIcon(
                              FontAwesomeIcons.italic,
                              size: 19,
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              if (_textType == TextType.italic) {
                                _textType = TextType.normal;
                              } else if (_textType == TextType.bold) {
                                _textType = TextType.italicBold;
                              } else if (_textType == TextType.italicBold) {
                                _textType = TextType.bold;
                              } else {
                                _textType = TextType.italic;
                              }
                              _noteBloc.changeTextDataSink.add(true);
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'A+',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_textSize < 30) {
                                _noteBloc.changeTextDataSink.add(true);
                                _textSize += 1;
                              }
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              'A-',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_textSize > 10) {
                                _noteBloc.changeTextDataSink.add(true);
                                _textSize -= 1;
                              }
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: StreamBuilder<bool>(
                          initialData: false,
                          stream: _noteBloc.loading,
                          builder: (context, snapshot) {
                            return TextButton(
                              child: Text(
                                widget.note != null ? 'Edit' : 'Save',
                                style: const TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: snapshot.data ?? false
                                    ? MaterialStateProperty.all<Color>(
                                        Colors.white12)
                                    : MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                overlayColor: snapshot.data ?? false
                                    ? null
                                    : MaterialStateProperty.all<Color>(
                                        Colors.white12),
                              ),
                              onPressed: snapshot.data ?? false
                                  ? null
                                  : () {
                                      _saveEditNote(widget.note == null);
                                    },
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(_createdDate,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                          IconButton(
                            icon: const Icon(
                              Icons.color_lens,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return CustomColorPicker(
                                    onSelectColor: (color) {
                                      _noteBloc.changeColorSink.add(color);
                                    },
                                    availableColors: [
                                      HexColor.fromHex(
                                          AppSettings().colorBlack74),
                                      HexColor.fromHex(AppSettings().colorRed),
                                      HexColor.fromHex(
                                          AppSettings().colorOrange),
                                      HexColor.fromHex(
                                          AppSettings().colorYellow),
                                      HexColor.fromHex(
                                          AppSettings().colorGreen),
                                      HexColor.fromHex(
                                          AppSettings().colorTurquoise),
                                      HexColor.fromHex(AppSettings().colorBlue),
                                      HexColor.fromHex(
                                          AppSettings().colorPurple),
                                      HexColor.fromHex(AppSettings().colorPink),
                                    ],
                                    initialColor: _noteColor,
                                    backgroundColor: HexColor.fromHex(
                                        AppSettings().colorBlack74),
                                  );
                                },
                              );
                            },
                          ),
                          //Pending function implementation
                          /*IconButton(
                            icon: const Icon(
                              Icons.add_box_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),*/
                          IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: widget.note != null
                                  ? () {
                                      _deleteNote();
                                    }
                                  : null),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _saveEditNote(bool isSave) async {
    int index = 0;
    await getPreferencesInt(AppSettings().indexCountKey!).then((value) {
      index = value == -1 ? 0 : index + value;
    });
    Note note = Note(
        isSave ? index : widget.note!.index,
        _controllerTitle.text.toString(),
        _controllerNote.text.toString(),
        DateTime.now(),
        _noteColor.toHex(),
        _isPinned,
        _textType.asString(),
        _textSize);
    _noteBloc.saveOrEditNote(note, isSave).then((value) {
      if (value.result != null && value.result != -1) {
        savePreferencesInt(AppSettings().indexCountKey!,
            isSave ? value.result! + 1 : value.result!);
        showSnackBar('Note saved!', context);
        Navigator.of(context).pop();
      } else {
        showSnackBar('Error: ${value.errorMsg}', context);
      }
    }).catchError((error) {
      showSnackBar('Error: $error', context);
    });
  }

  void _deleteNote() {
    _noteBloc.deleteNote(widget.note!).then((value) {
      if (value.result!) {
        showSnackBar('Note deleted!', context);
        Navigator.of(context).pop();
      } else {
        showSnackBar('Error: ${value.errorMsg}', context);
      }
    }).catchError((error) {
      showSnackBar('Error: $error', context);
    });
  }

  _showNote() {
    _controllerTitle.text = widget.note?.title ?? '';
    _controllerNote.text = widget.note?.content ?? '';
    _createdDate = DateFormat('MMM d, yyyy - h:mm aaa')
        .format(widget.note?.createdAt ?? DateTime.now());
    _noteColor = widget.note?.color != null
        ? HexColor.fromHex(widget.note!.color!)
        : HexColor.fromHex(AppSettings().colorBlack74);
    _isPinned = widget.note?.isPinned ?? false;
    _textSize = widget.note?.textSize ?? 18;
    _textType =
        stringToEnum(widget.note?.textType ?? 'normal') ?? TextType.normal;
  }
}
