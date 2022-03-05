import 'package:flutter/material.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/utils/extension_functions.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.textEditingController,
      required this.title,
      this.onTap,
      required this.iconData,
      required this.textColor})
      : super(key: key);

  final TextEditingController textEditingController;
  final String title;
  final GestureTapCallback? onTap;
  final Icon iconData;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: HexColor.fromHex(AppSettings().colorWhite10)),
      child: TextField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
            hintText: title,
            hintStyle:
                TextStyle(fontSize: 20.0, color: textColor),
            suffixIcon: InkWell(
              borderRadius: BorderRadius.circular(30.0),
              child: iconData,
              onTap: onTap,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            isDense: true,
            contentPadding:
                const EdgeInsets.only(bottom: 15, top: 15, left: 15, right: 15),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                borderRadius: BorderRadius.circular(30.0))),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
