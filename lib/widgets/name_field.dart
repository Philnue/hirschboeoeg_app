import 'dart:io';

import 'package:boeoeg_app/classes/constants.dart';
import 'package:boeoeg_app/classes/httpHelper.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/hive_flutter.dart';

class NamefieldWidget extends StatefulWidget {
  const NamefieldWidget({Key? key}) : super(key: key);

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

    _box = Hive.box("settings");
    //_textController =        TextEditingController(text: hiveHelper.loadDataString("name"));
    _textController = TextEditingController(text: _box.get("name"));

    _id = _box.get("id");

    print(_textController.text);
  }

  void setNameToHive(String name) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Vorname Nachname"),
          SizedBox(
            height: 10,
          ),
          CupertinoTextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            placeholder: "Vorname Nachname",
            autocorrect: false,
            decoration: BoxDecoration(
                border: Border.all(
              width: 0.5,
              color: CupertinoColors.white,
            )),
            onSubmitted: (value) {
              setState(() {
                _textController.text = value;
                _box.put("name", value);
                print(value);
                var httpHelper = HttpHelper();
                if (_id > 0) {
                  var datatext = _textController.text.split(" ");
                  var vorname = datatext[0];
                  var nachname = datatext[1];

                  httpHelper.updateMitlied(
                      path: Constants.updateMitlied,
                      crrid: _id,
                      vorname: vorname,
                      nachname: nachname);
                } else {
                  var datatext = _textController.text.split(" ");
                  var vorname = datatext[0];
                  var nachname = datatext[1];
                  httpHelper.addMitlied(
                      path: Constants.addMitlied,
                      vorname: vorname,
                      nachname: nachname);

                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: Text("Hinzufügen der Person"),
                            content: Text(
                                "Ihr Name $vorname $nachname wurde erfolgreich hinzugefügt bitte schließen sie die App und starten diese erneut"),
                            actions: [
                              CupertinoDialogAction(
                                child: Text("Ok"),
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
            prefix: Icon(CupertinoIcons.person),
          ),
        ],
      ),
    );
  }
}
