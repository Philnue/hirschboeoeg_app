import 'package:boeoeg_app/IOS/Pages/newsPage.dart';
import 'package:boeoeg_app/IOS/widgets/info/aemterWidget.dart';
import 'package:boeoeg_app/IOS/widgets/mitgliederView.dart';
import 'package:flutter/cupertino.dart';

import '../../classes/format.dart';

class InfoPageTest extends StatefulWidget {
  const InfoPageTest({Key? key}) : super(key: key);

  @override
  State<InfoPageTest> createState() => _InfoPageTestState();
}

class _InfoPageTestState extends State<InfoPageTest> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              controller: ScrollController(),
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Info Seite"),
                        CupertinoButton(
                          child: const Text(
                            "News",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.activeBlue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(NewsPage.routeName);
                          },
                        ),
                      ]),
                  middle: const Text("Ämter und Mitglieder"),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  const AemterWidget(),
                  const Text(
                    "Böögs",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  MitgliederView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
