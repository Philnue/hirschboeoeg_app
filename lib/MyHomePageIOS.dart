import 'package:boeoeg_app/IOS/Pages/newsPage.dart';
import 'package:boeoeg_app/IOS/Pages/settingsPage.dart';
import 'package:boeoeg_app/Theme.dart';
import 'package:boeoeg_app/iosTabScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'IOS/widgets/calendar/selectedCalendarItem.dart';
import 'IOS/widgets/poll/addPollItem.dart';
import 'IOS/widgets/poll/selectedPollItem.dart';

class MyHomePageIOS extends StatefulWidget {
  const MyHomePageIOS({Key? key, required this.mybrightness}) : super(key: key);

  final Brightness? mybrightness;

  @override
  State<MyHomePageIOS> createState() => _MyHomePageIOSState();
}

class _MyHomePageIOSState extends State<MyHomePageIOS> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _brighness = widget.mybrightness;

    return CupertinoApp(
        theme: _brighness == Brightness.dark
            ? MyTheme.darkThemeCupertino
            : MyTheme.lightThemeCupertino,
        home: const IOSTabScaffold(),
        routes: {
          SelectedCalendarItem.routeName: (context) =>
              const SelectedCalendarItem(),
          AddPoll.routeName: (context) => const AddPoll(),
          SelectedPollItem.routeName: (context) => const SelectedPollItem(),
          NewsPage.routeName: (context) => const NewsPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        });
  }
}
