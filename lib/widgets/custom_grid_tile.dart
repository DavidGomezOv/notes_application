import 'package:flutter/material.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/models/note.dart';
import 'package:notes_application/utils/extension_functions.dart';


class CustomGridTile extends StatelessWidget {
  const CustomGridTile({Key? key, required this.note, required this.onTap}) : super(key: key);

  final Note note;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: note.color != null ? HexColor.fromHex(note.color!) : HexColor.fromHex(AppSettings().colorBlack74),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: HexColor.fromHex(AppSettings().colorWhite38))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              note.content,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16.0),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
