import 'package:boeoeg_app/Android/Pages/calendarPage.dart';
import 'package:boeoeg_app/Android/Pages/infoPage.dart';
import 'package:boeoeg_app/Android/Pages/pollPage.dart';
import 'package:boeoeg_app/Android/Pages/settingsPage.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../classes/Api/mitglied.api.dart';
import '../classes/format.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late TextEditingController _controller = TextEditingController(text: "");
  final int _id = HiveHelper.currentId;
  //! teste

  @override
  void initState() {
    super.initState();

    //_textController =        TextEditingController(text: hiveHelper.loadDataString("name"));

    _controller = TextEditingController(text: HiveHelper.currentName);
    //! vllt wieder rein
    //_id = HiveHelper.currentId;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.amberAccent,
        child: Material(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    const Text("Herzlich Wilkommen!"),
                    TextField(
                        enabled: false,
                        controller: _controller,
                        onSubmitted: (value) {
                          setState(() {});
                        }),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    Navigator.pushReplacementNamed(
                        context, CalendarPage.routeName);
                  });
                },
                leading: const Icon(Icons.calendar_month),
                title: const Text("Kalender"),
              ),
              // ListTile(
              //   onTap: () {
              //     setState(() {
              //       Navigator.pushReplacementNamed(context, PollPage.routeName);
              //     });
              //   },
              //   leading: const Icon(Icons.poll),
              //   title: const Text("Abstimmungen"),
              // ),
              ListTile(
                onTap: () {
                  setState(() {
                    Navigator.pushReplacementNamed(
                        context, SettingsPage.routeName);
                  });
                },
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    Navigator.pushReplacementNamed(context, InfoPage.routeName);
                  });
                },
                leading: const Icon(Icons.info),
                title: const Text("Info"),
              ),
            ],
          ),
        ));
  }
}
