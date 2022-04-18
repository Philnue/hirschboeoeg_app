import 'package:boeoeg_app/Android/Pages/calendarPage.dart';
import 'package:boeoeg_app/Android/Pages/infoPage.dart';
import 'package:boeoeg_app/Android/Pages/pollPage.dart';
import 'package:boeoeg_app/Android/Pages/settingsPage.dart';

import 'package:flutter/material.dart';

import 'Android/Widgets/calendar/selectedCalendarItemAndroid.dart';
import 'Theme.dart';
import 'classes/Api/notification.api.dart';
import 'classes/Api/termin.api.dart';
import 'classes/Models/termin.dart';

class MyHomePageAndroid extends StatefulWidget {
  const MyHomePageAndroid({Key? key, required this.mybrightness})
      : super(key: key);
  final Brightness? mybrightness;
  @override
  State<MyHomePageAndroid> createState() => _MyHomePageAndroidState();
}

class _MyHomePageAndroidState extends State<MyHomePageAndroid> {
  

  @override
  Widget build(BuildContext context) {
    var _brightness = widget.mybrightness;

    return MaterialApp(
      home: const CalendarPage(),
      theme: _brightness == Brightness.dark
          ? MyTheme.darkThemeAndroid
          : MyTheme.lightThemeAndroid,
      //routes
      routes: {
        PollPage.routeName: (context) => const PollPage(),
        CalendarPage.routeName: (context) => const CalendarPage(),
        SelectedCalendarItemAndroid.routeName: (context) =>
            const SelectedCalendarItemAndroid(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        InfoPage.routeName: (context) => const InfoPage(),
      },
    );
  }
}
