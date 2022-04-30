import 'package:boeoeg_app/IOS/widgets/settings/name_field.dart';
import 'package:boeoeg_app/IOS/widgets/settings/short_name.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

import '../../classes/format.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static final String routeName = "settingsPage";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int daysPicker = 0;
  DateTime timePicker = DateTime.now().add(
    Duration(minutes: 5 - DateTime.now().minute % 5),
  );
  @override
  void initState() {
    // TODO: implement initState
    // TODO:
    //! ERROR

    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Einstellungen ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NamefieldWidget(act: refresh),
          HiveHelper.currentId != 0
              ? ShortNameWidget()
              : Text("Bitte erst namen eintippen"),
          const Text(
            "Uhrzeit für die Mitteilung",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            flex: 3,
            child: CupertinoDatePicker(
              use24hFormat: true,

              initialDateTime: HiveHelper.initValue,
              // initialDateTime: DateTime.now().add(
              //   Duration(minutes: 5 - DateTime.now().minute % 5),
              // ),
              minuteInterval: 5,
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                setState(() {
                  timePicker = value;
                  print(timePicker);
                });
                var selectedTime = value;
              },
            ),
          ),
          const Text(
            "Wie viele Tage vorher",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 4,
            child: CupertinoPicker(
              onSelectedItemChanged: (value) {
                setState(() {
                  daysPicker = value;
                });
              },
              itemExtent: 25,
              useMagnifier: true,
              magnification: 1.3,
              children: const [
                Text("Selber Tag"), //ehute
                Text("1 Tag"), //morgen
                Text("2 Tage"), //in
                Text("3 Tage"),
                Text("4 Tage"),
                Text("5 Tage"),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: CupertinoButton(
              color: CupertinoColors.systemBlue,
              disabledColor: CupertinoColors.systemGrey,
              child: Text(
                "Speichern",
                style: TextStyle(color: CupertinoColors.white),
              ),
              onPressed: Format.isAcceptTime
                  ? () {
                      HiveHelper.writeNotificationToDevice(
                          daysPicker, timePicker);
                    }
                  : null,
            ),
          )
        ],
      )),
    );
  }
}
