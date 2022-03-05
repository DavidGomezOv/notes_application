import 'package:flutter/material.dart';
import 'package:notes_application/core/app_settings.dart';
import 'package:notes_application/utils/extension_functions.dart';

class ShowErrorScreen extends StatelessWidget {
  final String errorMsg;
  final Future<void> Function() onRefresh;

  const ShowErrorScreen(
      {Key? key, required this.errorMsg, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              errorMsg,
              style: TextStyle(color: HexColor.fromHex(AppSettings().colorWhite70), fontSize: 18),
            ),
          ),
          ListView()
        ],
      ),
      onRefresh: onRefresh,
    ));
  }
}
