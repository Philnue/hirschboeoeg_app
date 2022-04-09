import 'package:boeoeg_app/classes/format.dart';

import 'package:boeoeg_app/classes/Api/termin.api.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/kalendaritem.dart';

import 'package:flutter/cupertino.dart';

import '../../classes/Models/termin.dart';

class CalendarPageTest extends StatefulWidget {
  const CalendarPageTest({Key? key}) : super(key: key);

  @override
  _CalendarPageTestState createState() => _CalendarPageTestState();
}

class _CalendarPageTestState extends State<CalendarPageTest> {
  List<dynamic> allEntries = [];

  List<Termin> _terminlist = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getTermine();
  }

  Future<void> getTermine() async {
    //!Internet schauen wenn offline
    _terminlist = await TerminApi.loadAllTermine();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _isLoading
          ? const CupertinoActivityIndicator()
          : SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: Text(
                      Format.currentDate,
                    ),
                    middle: const Text("Alle Termine"),
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () {
                      return Future<void>.delayed(const Duration(seconds: 1))
                        ..then((_) => getTermine());
                    },
                  ),

                  // Other sliver

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return KalendarItem(actTermin: _terminlist[index]);
                        //return TestCard(termin: _terminlist[index]);
                      },
                      childCount: _terminlist.length,
                      addAutomaticKeepAlives: true,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
