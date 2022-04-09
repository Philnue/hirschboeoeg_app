import 'package:boeoeg_app/classes/format.dart';
import 'package:boeoeg_app/classes/Api/termin.api.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/kalendaritem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/Models/termin.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<dynamic> allEntries = [];

  List<Termin> _terminlist = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getTermine();
  }

  Future<List<Termin>> getTermine() async {
    _terminlist = await TerminApi.loadAllTermine();

    return _terminlist;
    //setState(() {
    //  _isLoading = false;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Kalender " + Format.currentDate,
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: _isLoading
          ? const CupertinoActivityIndicator()
          : SafeArea(
              child: FutureBuilder<List<Termin>>(
                builder: (context, AsyncSnapshot<List<Termin>> projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none) {
                    return const Text("connection none");
                  }
                  if (projectSnap.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  return ListView.builder(
                    itemCount: projectSnap.data!.length,
                    itemBuilder: (context, index) {
                      var item = projectSnap.data!;
                      return KalendarItem(actTermin: item[index]);
                    },
                  );
                },
                future: getTermine(),
              ),
            ),
    );
  }
}
