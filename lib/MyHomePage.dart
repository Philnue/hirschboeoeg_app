import 'package:boeoeg_app/info_page.dart';
import 'package:boeoeg_app/kalendar_page.dart';
import 'package:boeoeg_app/settings_page.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    //loadPrefs();
  }

  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Kalender',
          ),
          //BottomNavigationBarItem(
          //  icon: Icon(CupertinoIcons.check_mark),
          //  label: 'Abstimmung',
          //),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Einstellungen/V',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            label: 'Info',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return const KalendarClass();
          case 1:
            return const SettingsPage();
          case 2:
            return const InfoPage();
          //case 3:
          // break;
          default:
            break;
        }
        return const Text("Fehler");
      },
    );
  }
}
