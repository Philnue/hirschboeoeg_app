import 'package:cliquenpackage/init.dart';
import 'package:cliquenpackage/platform/Android/MyHomePageAndroid.dart';
import 'package:cliquenpackage/platform/IOS/MyHomePageIOS.dart';
import 'package:cliquenpackage/utils/Api/mitglied.api.dart';
import 'package:cliquenpackage/utils/Models/mitglied.dart';
import 'package:cliquenpackage/utils/calendarHelper.dart';
import 'package:cliquenpackage/utils/constants/allConstants.dart';
import 'package:cliquenpackage/utils/hiveHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io' show Platform;

//void main() => runApp(MyApp());

void main() async {
  try {
    await Hive.initFlutter();
    await Hive.openBox('settings');
    // await Hive.box("settings")
    //     .put("connection", "http://vxf7ds3aa3ppmrja.myfritz.net:43333/");

    var aemterMap = [
      {"Amt": "Alpha        ", "Name": "Daniel Lauer"},
      {"Amt": "Beta         ", "Name": "Philipp Nüßlein"},
      {"Amt": "Schriftführer", "Name": "Dennis Hofmann"},
      {"Amt": "Finanzen     ", "Name": "Uwe Ziefle"},
    ];

    //herten http://vxf7ds3aa3ppmrja.myfritz.net:43333/
    //"http://t0orznhg4raqbvfi.myfritz.net:43333/";
    Init(
        adminList: [1, 2, 4, 5],
        aemterList: aemterMap,
        connection: "http://vxf7ds3aa3ppmrja.myfritz.net:43333/");

    await CalendarHelper();

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

      HiveHelper.terminList();
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
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.window.platformBrightness;

    // NotificationApi.init();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness = WidgetsBinding.instance.window.platformBrightness;
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

    var t = AllConstants.fritzBoxConnection;
    return isIOS
        ? MyHomePageIOS(mybrightness: _brightness)
        : MyHomePageAndroid(mybrightness: _brightness);
    //return isIOS ? const MyHomePageIOS(bnreighness) : const MyHomePageAndroid(brighness);
  }
}
