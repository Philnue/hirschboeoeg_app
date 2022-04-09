import 'package:boeoeg_app/IOS/widgets/settings/name_field.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Einstellungen ",
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: SafeArea(
          child: Column(
        children: const [
          NamefieldWidget(),
          //  HiveHelper.isVerified ? Container() : LicenseRegisterTextField(),
          Text(
            "Liste aller Neuigkeiten",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text("App wurde offiziell hochgeladen"),
        ],
      )),
    );
  }
}
