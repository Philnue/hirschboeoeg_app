import 'package:boeoeg_app/IOS/Pages/pollPageTest.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/selectedCalendarItem.dart';
import 'package:boeoeg_app/classes/Api/termin.api.dart';
import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:flutter/cupertino.dart';

import 'IOS/Pages/calendarPageTest.dart';
import 'IOS/Pages/infoPageTest.dart';
import 'IOS/Pages/licenseRegisterPage.dart';
import 'IOS/Pages/settingsPage.dart';
import 'classes/Api/notification.api.dart';
import 'classes/hiveHelper.dart';

class IOSTabScaffold extends StatefulWidget {
  const IOSTabScaffold({Key? key}) : super(key: key);

  @override
  State<IOSTabScaffold> createState() => _IOSTabScaffoldState();
}

class _IOSTabScaffoldState extends State<IOSTabScaffold> {
  @override
  void initState() {
    NotificationApi.init(initScheduled: true);
    listenNotifications();
    super.initState();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotifications);

  void onClickedNotifications(String? payload) async {
    if (payload != null) {
      Termin payloadTermin = await TerminApi.loadTerminById(payload);

      Navigator.of(context)
          .pushNamed(SelectedCalendarItem.routeName, arguments: payloadTermin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Termine',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.check_mark),
          //   label: 'Abstimmung',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.settings),
          //   label: 'Einstellungen',
          // ),
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
              return const InfoPageTest();
            //case 2:
            // return const InfoPageTest();

            default:
              break;
          }
        }

        return const Text("Fehler");
      },
    );
  }
}
