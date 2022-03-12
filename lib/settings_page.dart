import 'package:boeoeg_app/widgets/name_field.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _textController;
  TextEditingController controller =
      new TextEditingController(text: "Codesinsider.com");
  @override
  void initState() {
    super.initState();
    //_textController = TextEditingController(text: 'initial text');

    //loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Einstellungen ",
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).primaryColor,
        )),
      ),
      child: SafeArea(
        child: NamefieldWidget(),
      ),
    );
  }
}
