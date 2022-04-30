import 'package:boeoeg_app/adminInfoWidget.dart';
import 'package:flutter/material.dart';

import '../../classes/Models/mitglied.dart';
import '../../classes/Models/terminAbstimmung.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  static const String routeName = "/adminView";

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  bool isLoading = true;
  bool madeFirst = false;

  List<TerminAbstimmung> kommenList = [];
  List<TerminAbstimmung> abgelehntList = [];
  List<Mitglied> keineAntwort = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Ansicht"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      // drawer: const DrawerWidget(),
      body: SafeArea(
          child: AdminInfoWidget(
        id: args,
      )),
    );
  }
}
