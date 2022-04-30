import 'package:boeoeg_app/MyHomePageAndroid.dart';
import 'package:boeoeg_app/MyHomePageIOS.dart';
import 'package:boeoeg_app/classes/Api/notification.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:boeoeg_app/classes/calendarHelper.dart';
import 'package:boeoeg_app/classes/constants/constants.dart';
import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io' show Platform;

import 'IOS/widgets/calendar/selectedCalendarItem.dart';
import 'classes/Api/termin.api.dart';

//void main() => runApp(MyApp());

void main() async {
  try {
    await Hive.initFlutter();
    await Hive.openBox('settings');

    await CalendarHelper();

    // var t = await CalendarHelper().loadData();

    // List<Termin> liste = [
    //   Termin(
    //       id: 1,
    //       name: "name1",
    //       datum: "datum1",
    //       adresse: "adresse1",
    //       uhrzeit: "uhrzeit1",
    //       notizen: "notizen1",
    //       treffpunkt: "treffpunkt1",
    //       kleidung: "kleidung"),
    //   Termin(
    //       id: 2,
    //       name: "name2",
    //       datum: "datum2",
    //       adresse: "adresse2",
    //       uhrzeit: "uhrzeit2",
    //       notizen: "notizen2",
    //       treffpunkt: "treffpunkt2",
    //       kleidung: "kleidung2")
    // ];

    // await Hive.box("settings").put("test", liste);

    //String? name = await Hive.box("settings").get("name");
    var crrName = HiveHelper.currentName;
    //! ändern
    // if (name == null) {
    //  name = "1 2";
    // }
    //! testen

    //! Problem Lauer

    if (crrName != "") {
      Mitglied currentMitglied = await MitgliedApi.loadFullMitliedByName(
          crrName.split(" ")[0], crrName.split(" ")[1]);

      await Hive.box("settings").put("spitzName", currentMitglied.spitzName);

      await Hive.box("settings").put("id", currentMitglied.id);

      print("crrPersonId = ${currentMitglied.id} ");
      print("crrSpitzname = ${currentMitglied.spitzName} ");
    } else {
      await Hive.box("settings").put("id", 0);
    }

    runApp(MyApp());
  } catch (_) {
    print(_.toString());
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  //static const String _title = 'WhatsBöög';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _brightness = WidgetsBinding.instance?.window.platformBrightness;

    // NotificationApi.init();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance?.window.platformBrightness;
      });
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    var isIOS = Platform.isIOS;
    //return für android / ios
    //! connected internet ?
    //! Alerts :

    return isIOS
        ? MyHomePageIOS(mybrightness: _brightness)
        : MyHomePageAndroid(mybrightness: _brightness);
    //return isIOS ? const MyHomePageIOS(bnreighness) : const MyHomePageAndroid(brighness);
  }
}
