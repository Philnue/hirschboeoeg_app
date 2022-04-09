import 'dart:io';

import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/format.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/hive_flutter.dart';

class ShortNameWidget extends StatefulWidget {
  const ShortNameWidget({Key? key}) : super(key: key);

  @override
  _ShortNameWidgetState createState() => _ShortNameWidgetState();
}

class _ShortNameWidgetState extends State<ShortNameWidget> {
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
              ? const Text("Spitzname")
              : const Text("Saufmodus ist aktviert"),
          //const Text("Vorname Nachname"),
          const SizedBox(
            height: 10,
          ),
          CupertinoTextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            placeholder: "Spitzname",
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

                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: const Text("Hinzufügen des Spitzname"),
                            content: Text(
                                "Ihr Spitzname $vorname $nachname wurde erfolgreich hinzugefügt bitte schließen sie die App und starten diese erneut"),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  exit(0);
                                },
                              )
                            ],
                          ));
                }
              });
            },
            prefix: const Icon(CupertinoIcons.person),
          ),
        ],
      ),
    );
  }
}
