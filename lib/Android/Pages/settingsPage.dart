import 'package:boeoeg_app/Android/AndroidAlertDialogCustom.dart';
import 'package:boeoeg_app/Android/Widgets/androidTextField.dart';
import 'package:boeoeg_app/Android/drawerWidget.dart';
import 'package:flutter/material.dart';

import '../../classes/Api/mitglied.api.dart';
import '../../classes/format.dart';
import '../../classes/hiveHelper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = "settingsPage";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _controller =
      TextEditingController(text: HiveHelper.currentName);
  final int _id = HiveHelper.currentId;

  void name(String value) {
    var oldname = HiveHelper.currentName;
    bool worked = HiveHelper.writeName(value);
    var datatext = value.split(" ");
    String vorname = datatext[0];
    String nachname = datatext[1];

    if (_id > 0) {
      MitgliedApi.updateMitlied(
          crrid: _id, vorname: vorname, nachname: nachname);

      AndroidAlertDialogCustom.showAlertDialog(
          "Namensänderung",
          "Alter Name: $oldname\nNeuer Name: $value\nÄnderungen wurden vorgenommen",
          context, [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ]);
    } else {
      AndroidAlertDialogCustom.showAlertDialog("Neuer Name wurde hinzugefügt",
          "Neuer Name: $value wurde erfolgreich hinzugefügt", context, [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ]);

      MitgliedApi.addMitlied(vorname: vorname, nachname: nachname);
    }
  }

  void shortName(String value) {
    MitgliedApi.addOrUpdateShortNameAndroid(value, context);
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: HiveHelper.currentName);
    //! vllt wieder rein
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einstellungen"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AndroidTextField(
                title: "Vorname Nachname",
                func: name,
                initValue: HiveHelper.currentName),
            HiveHelper.currentId != 0
                ? AndroidTextField(
                    title: "Spitzname",
                    func: shortName,
                    initValue: HiveHelper.currentSpitzName,
                  )
                : const Text("Bitte erst einen Namen eintippen"),
          ],
        ),
      ),
    );
  }
}
