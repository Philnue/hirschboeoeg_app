import 'dart:io';

import 'package:boeoeg_app/IOS/widgets/cupertinoAlertDialogCustom.dart';
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

  late int _id;
  @override
  void initState() {
    super.initState();

    //_box = Hive.box("settings");

    //_textController =        TextEditingController(text: hiveHelper.loadDataString("name"));
    _textController =
        TextEditingController(text: HiveHelper.currentSpitzName); //shortname

    _id = HiveHelper.currentId;

    var m = HiveHelper.currentSpitzName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Spitzname",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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

                MitgliedApi.addOrUpdateShortNameCupertino(value, context);
              });
            },
            prefix: const Icon(CupertinoIcons.person),
          ),
        ],
      ),
    );
  }
}
