import 'package:boeoeg_app/Android/drawer_widget.dart';
import 'package:flutter/material.dart';

import '../../IOS/widgets/info/aemterWidget.dart';
import '../../IOS/widgets/mitgliederView.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const routeName = "infoPage";

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Seite"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: const Drawer_Widget(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const AemterWidget(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Alle registrierten Mitglieder",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                MitgliederView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
