import 'dart:io';

import 'package:boeoeg_app/IOS/Pages/qrPage.dart';
import 'package:boeoeg_app/classes/Api/terminAbstimmung.api.dart';
import 'package:boeoeg_app/classes/Models/terminTerminAbstimmung.dart';
import 'package:boeoeg_app/classes/format.dart';

import 'package:boeoeg_app/classes/Api/termin.api.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/kalendaritem.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';

import 'package:flutter/cupertino.dart';

import '../../classes/Models/termin.dart';

class CalendarPageTest extends StatefulWidget {
  const CalendarPageTest({Key? key}) : super(key: key);

  @override
  _CalendarPageTestState createState() => _CalendarPageTestState();
}

class _CalendarPageTestState extends State<CalendarPageTest> {
  //List<dynamic> allEntries = [];

  //List<Termin> _terminlist = [];
  List<TerminTerminAbstimmung> _terminTerminAbstimmungen = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getTermine();
  }

  Future<void> getTermine() async {
    //!Internet schauen wenn offline

    //_terminlist = await TerminApi.loadAllTermine();

    _terminTerminAbstimmungen = await TerminApi.loadAllTermineMitAbstimmung();

    TerminAbstimmungApi.makeSaufiMode(_terminTerminAbstimmungen);

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
                    largeTitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Format.currentDate,
                        ),
                        CupertinoButton(
                          child: Icon(CupertinoIcons.refresh, size: 30),
                          onPressed: () => {getTermine()},
                        ),
                      ],
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
                        return KalendarItem(
                          actTermin: _terminTerminAbstimmungen[index].termin,
                          entscheidung:
                              _terminTerminAbstimmungen[index].terminAbstimmung,
                        );
                        //return TestCard(termin: _terminlist[index]);
                      },
                      childCount: _terminTerminAbstimmungen.length,
                      addAutomaticKeepAlives: true,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
