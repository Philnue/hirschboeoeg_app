import 'package:boeoeg_app/IOS/Pages/calendarPageTest.dart';
import 'package:boeoeg_app/IOS/Pages/infoPageTest.dart';
import 'package:boeoeg_app/IOS/Pages/licenseRegisterPage.dart';
import 'package:boeoeg_app/IOS/Pages/newsPage.dart';
import 'package:boeoeg_app/IOS/Pages/pollPageTest.dart';
import 'package:boeoeg_app/IOS/Pages/settingsPage.dart';
import 'package:boeoeg_app/Theme.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';
import 'Archive/calendarPage.dart';
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

    //loadPrefs();
  }

//cupterino app noch reinmachen
  @override
  Widget build(BuildContext context) {
    var _brighness = widget.mybrightness;

    return CupertinoApp(
        theme: _brighness == Brightness.dark
            ? MyTheme.darkThemeCupertino
            : MyTheme.lightThemeCupertino,
        home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar),
                label: 'Termine',
              ),
              //BottomNavigationBarItem(
              //  icon: Icon(CupertinoIcons.check_mark),
              //  label: 'Abstimmung',
              //),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Einstellungen',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.info),
                label: 'Info',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            if (HiveHelper.isVerified == false) {
              return const LicenseRegisterPage();
            } else {
              switch (index) {
                case 0:
                  return const CalendarPageTest();

                //case 1:
                //  return const PollPageTest();

                case 1:
                  return const SettingsPage();

                case 2:
                  return const InfoPageTest();

                default:
                  break;
              }
            }

            return const Text("Fehler");
          },
        ),
        routes: {
//'/': (context) => const FirstScreen(),
          SelectedCalendarItem.routeName: (context) =>
              const SelectedCalendarItem(),

          AddPoll.routeName: (context) => const AddPoll(),
          SelectedPollItem.routeName: (context) => const SelectedPollItem(),
          NewsPage.routeName:(context) => const NewsPage(),
        });
  }
}
