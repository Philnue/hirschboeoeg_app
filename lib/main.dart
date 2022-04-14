import 'package:boeoeg_app/MyHomePageAndroid.dart';
import 'package:boeoeg_app/MyHomePageIOS.dart';
import 'package:boeoeg_app/classes/Api/notification.api.dart';
import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:boeoeg_app/classes/constants/constants.dart';
import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
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

    List<Termin> liste = [
      Termin(
          id: 1,
          name: "name1",
          datum: "datum1",
          adresse: "adresse1",
          uhrzeit: "uhrzeit1",
          notizen: "notizen1",
          treffpunkt: "treffpunkt1",
          kleidung: "kleidung"),
      Termin(
          id: 2,
          name: "name2",
          datum: "datum2",
          adresse: "adresse2",
          uhrzeit: "uhrzeit2",
          notizen: "notizen2",
          treffpunkt: "treffpunkt2",
          kleidung: "kleidung2")
    ];

    //var mm = HiveHelper.putAllTermine(liste);
    //var mmm = await HiveHelper.getallTermine();

    var apiAvailable = await Constants.checkInternetConnection();

    if (apiAvailable) {
    } else {}
    //var m = Hive.box("settings").put("termine", liste);

    //var tt = Hive.box("settings").get("termine") as List<Termin>;

    String? name = await Hive.box("settings").get("name");

    //! ändern
    // if (name == null) {
    //  name = "1 2";
    // }
    //! testen
    var vorname = name?.split(" ")[0];
    var nachname = name?.split(" ")[1];

    if (name != null) {
      int crrId = await MitgliedApi.loadMitliedIdByName(
          MitgliedApi.getMitliedByIdString + "$vorname,$nachname");
      await Hive.box("settings").put("id", crrId);
      print("crrPerson = $crrId ");
    } else {
      await Hive.box("settings").put("id", 0);
    }

    print("Id = ${HiveHelper.currentId}");
    print("IdSet = ${HiveHelper.isIdSet}");

    //var t = await LizenzApi.isVerified("hirschboeoeg");
    //print(t);

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
