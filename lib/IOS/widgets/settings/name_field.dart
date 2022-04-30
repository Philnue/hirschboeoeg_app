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

  //late int _id;
  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: HiveHelper.currentName);
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

                //! mit " " rein
                //! namens kontrolle

                var old = HiveHelper.currentName;
                bool worked = HiveHelper.writeName(value);
                var datatext = _textController.text.split(" ");
                String vorname = datatext[0];
                String nachname = datatext[1];

                if (HiveHelper.currentId > 0) {
                  MitgliedApi.updateMitlied(
                      crrid: HiveHelper.currentId,
                      vorname: vorname,
                      nachname: nachname);

                  CupertinoAlertDialogCustom.showAlertDialog(
                    context,
                    "Bearbeiten der Person",
                    "Ihr Name $old wurde zu $value erfolgreich geändert",
                    [
                      CupertinoDialogAction(
                        child: const Text("Ok"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                } else {
                  MitgliedApi.addMitlied(vorname: vorname, nachname: nachname);

                  CupertinoAlertDialogCustom.showAlertDialog(
                    context,
                    "Hinzufügen der Person",
                    "Ihr Name $vorname $nachname wurde erfolgreich hinzugefügt, sie können nun Terminabstimmungen hinzufügen",
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
