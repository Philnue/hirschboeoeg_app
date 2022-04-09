import 'package:boeoeg_app/Android/Widgets/calendar/calendaritemAndroid.dart';
import 'package:boeoeg_app/Android/drawerWidget.dart';
import 'package:flutter/material.dart';

import '../../classes/Api/termin.api.dart';
import '../../classes/Models/termin.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const String routeName = "calendarPage";

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Termin> _terminlist = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getTermine();
  }

  Future<void> getTermine() async {

    //! wenn offline 
    _terminlist = await TerminApi.loadAllTermine();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("Kalendareinträge"),
      ),
      drawer: const DrawerWidget(),
      body: _isLoading
          ? const CircularProgressIndicator(
              color: Colors.blue,
            )
          : SafeArea(
              //! refresh einbauen
              child: RefreshIndicator(
                color: Colors.blue,
                onRefresh: getTermine,
                child: ListView.builder(
                  itemCount: _terminlist.length,
                  itemBuilder: (context, index) {
                    return CalendarItemAndroid(actTermin: _terminlist[index]);
                  },
                ),
              ),
            ),
    );
  }
}
