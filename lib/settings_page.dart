import 'package:boeoeg_app/widgets/name_field.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Einstellungen ",
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).primaryColor,
        )),
      ),
      child: const SafeArea(
        child: NamefieldWidget(),
      ),
    );
  }
}
