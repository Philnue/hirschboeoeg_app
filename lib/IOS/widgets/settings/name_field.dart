import 'package:boeoeg_app/IOS/widgets/cupertinoAlertDialogCustom.dart';
import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/format.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/hive_flutter.dart';

class NamefieldWidget extends StatefulWidget {
  const NamefieldWidget({Key? key, required this.act}) : super(key: key);
  final Function act;
  @override
  _NamefieldWidgetState createState() => _NamefieldWidgetState();
}

class _NamefieldWidgetState extends State<NamefieldWidget> {
  late TextEditingController _textController;
  late Box<dynamic> _box;

  late int _id;
  @override
  void initState() {
    super.initState();

    //_box = Hive.box("settings");

    //_textController =        TextEditingController(text: hiveHelper.loadDataString("name"));
    _textController = TextEditingController(text: HiveHelper.currentName);

    _id = HiveHelper.currentId;

    print(_textController.text);
  }

  void setNameToHive(String name) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Format.isAcceptTime
              ? const Text(
                  "Vorname Nachname",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : const Text(
                  "Saufmodus ist aktviert",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemRed),
                ),
          //const Text("Vorname Nachname"),
          const SizedBox(
            height: 10,
          ),
          CupertinoTextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            placeholder: "Vorname Nachname",
            autocorrect: false,
            enabled: Format.isAcceptTime,
            decoration: BoxDecoration(
                border: Border.all(
              width: 0.8,
              color: CupertinoColors.systemBlue,
            )),
            onSubmitted: (value) {
              setState(() {
                _textController.text = value;

                //_box.put("name", value);

                bool worked = HiveHelper.writeName(value);
                print(value);

                var datatext = _textController.text.split(" ");
                String vorname = datatext[0];
                String nachname = datatext[1];

                if (_id > 0) {
                  MitgliedApi.updateMitlied(
                      crrid: _id, vorname: vorname, nachname: nachname);
                } else {
                  MitgliedApi.addMitlied(vorname: vorname, nachname: nachname);

                  CupertinoAlertDialogCustom.showAlertDialog(
                    context,
                    "Hinzufügen der Person",
                    "Ihr Name $vorname $nachname wurde erfolgreich hinzugefügt bitte schließen sie die App und starten diese erneut",
                    [
                      CupertinoDialogAction(
                        child: const Text("Ok"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                }
                widget.act;
              });
            },
            prefix: const Icon(CupertinoIcons.person),
          ),
        ],
      ),
    );
  }
}
