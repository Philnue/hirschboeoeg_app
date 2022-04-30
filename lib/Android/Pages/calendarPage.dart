import 'dart:io';

import 'package:boeoeg_app/Android/Widgets/calendar/calendaritemAndroid.dart';
import 'package:boeoeg_app/Android/drawerWidget.dart';
import 'package:boeoeg_app/classes/Models/terminTerminAbstimmung.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../classes/Api/notification.api.dart';
import '../../classes/Api/termin.api.dart';
import '../../classes/Api/terminAbstimmung.api.dart';
import '../../classes/Models/termin.dart';
import '../../classes/format.dart';
import '../Widgets/calendar/selectedCalendarItemAndroid.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const String routeName = "calendarPage";

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotifications);

  void onClickedNotifications(String? payload) async {
    if (payload != null) {
      Termin payloadTermin = await TerminApi.loadTerminById(payload);

      Navigator.of(context).pushNamed(SelectedCalendarItemAndroid.routeName,
          arguments: payloadTermin);
    }
  }

  //List<Termin> _terminlist = [];
  List<TerminTerminAbstimmung> _terminTerminAbstimmungen = [];
  bool _isLoading = true;
  @override
  void initState() {
    NotificationApi.init(initScheduled: true);
    listenNotifications();

    getTermine();
    super.initState();
  }

  Future<List<TerminTerminAbstimmung>> getData() async {
    return await TerminApi.loadAllTermineMitAbstimmung();
  }

  Future<void> getTermine() async {
    //! wenn offline
    //_terminlist = await TerminApi.loadAllTermine();

    _terminTerminAbstimmungen = await TerminApi.loadAllTermineMitAbstimmung();

    // var today = DateTime.now();

    // var todayList = _terminTerminAbstimmungen.where((element) =>
    //     (today.isSameDate(element.termin.terminAsDateTimeWithoutTime) &&
    //         element.terminAbstimmung == 1 &&
    //         today.isAfter(element.termin.terminAsDateTime)));

    // if (todayList.isNotEmpty) {
    //   Hive.box("settings").put("saufiAktiviert", true);
    // }
    // if (todayList.isEmpty) {
    //   Hive.box("settings").put("saufiAktiviert", false);
    // }

    TerminAbstimmungApi.makeSaufiMode(_terminTerminAbstimmungen);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              getTermine();
            },
            child: Icon(
              Icons.refresh,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Kalendareinträge"),
      ),
      drawer: const DrawerWidget(),
      body: FutureBuilder<List<TerminTerminAbstimmung>>(
        builder:
            (context, AsyncSnapshot<List<TerminTerminAbstimmung>> projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none) {
            return const Text("connection none");
          }
          if (projectSnap.connectionState == ConnectionState.waiting) {
            const CircularProgressIndicator(
              color: Colors.blue,
            );
          } else {
            if (projectSnap.hasData && !projectSnap.hasError) {
              return ListView.builder(
                itemCount: _terminTerminAbstimmungen.length,
                itemBuilder: (context, index) {
                  return CalendarItemAndroid(
                    actTermin: _terminTerminAbstimmungen[index].termin,
                    entscheidung:
                        _terminTerminAbstimmungen[index].terminAbstimmung,
                  );
                },
              );
            }
          }
          return const Text("Loading");
        },
        future: getData(),
      ),
    );
  }
}
