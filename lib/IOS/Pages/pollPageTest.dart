import 'package:boeoeg_app/IOS/Pages/settingsPage.dart';
import 'package:boeoeg_app/IOS/widgets/cupertinoAlertDialogCustom.dart';
import 'package:boeoeg_app/classes/Api/abstimmung.api.dart';
import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:boeoeg_app/IOS/widgets/poll/pollItem.dart';
import 'package:boeoeg_app/classes/format.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';

import '../../IOS/widgets/poll/addPollItem.dart';

class PollPageTest extends StatefulWidget {
  const PollPageTest({Key? key}) : super(key: key);

  @override
  State<PollPageTest> createState() => _PollPageTestState();
}

class _PollPageTestState extends State<PollPageTest> {
  bool _isLoading = true;
  List<Abstimmung> _allAbstimmungen = [];

  Future<void> getAllAbstimmungen() async {
    _allAbstimmungen = await AbstimmungApi.loadAllAbstimmungen();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllAbstimmungen();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: _isLoading
            ? const CupertinoActivityIndicator()
            : SafeArea(
                child: CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      largeTitle: const Text('Abstimmungen'),
                      middle: const Text("Abstimmung hinzufügen"),
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.add,
                          size: 30,
                        ),
                        onPressed: Format.isAcceptTime
                            ? () {
                                if (HiveHelper.isIdSet) {
                                  Navigator.of(context)
                                      .pushNamed(AddPoll.routeName);
                                } else {
                                  CupertinoAlertDialogCustom.showAlertDialog(
                                    context,
                                    "Fehler",
                                    "Bitte definieren sie erst einen in den Einstellungen",
                                    [
                                      CupertinoDialogAction(
                                        child: const Text("Einstellungen"),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  SettingsPage.routeName);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text("Schließen"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                }
                              }
                            : null,
                      ),
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: () {
                        return Future<void>.delayed(const Duration(seconds: 1))
                          ..then((_) => getAllAbstimmungen());
                      },
                    ),
                    // Other sliver elements
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return PollItem(
                              actAbstimmung: _allAbstimmungen[index]);
                        },
                        childCount: _allAbstimmungen.length,
                      ),
                    )
                  ],
                ),
              ));
  }
}
