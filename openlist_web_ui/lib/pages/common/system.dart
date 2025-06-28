import 'package:flutter/material.dart';

import 'package:openlist_global/config/config.dart';
import 'package:openlist_web_ui/l10n/generated/openlist_web_ui_localizations.dart';

class SystemPage extends StatefulWidget {
  SystemPage({ Key? key}) : super(key: key);

  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  String version = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List _result = [];
    // AList固定信息
    _result.add("AListWebAPIBaseUrl: $AListWebAPIBaseUrl");
    _result.add("AListAPIBaseUrl: $AListAPIBaseUrl");
    _result.add("WebPageBaseUrl: $WebPageBaseUrl");

    final tiles = _result.map(
      (pair) {
        return ListTile(
          title: Text(
            pair,
          ),
        );
      },
    );
    List<ListTile> tilesList = tiles.toList();
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tilesList,
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text(OpenListWebUiLocalizations.of(context).app_info), actions: <Widget>[
      ]),
      body: ListView(children: divided),
    );
  }
}
