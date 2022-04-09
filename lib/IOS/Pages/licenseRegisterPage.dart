import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/hiveHelper.dart';
import '../widgets/settings/licenseRegisterTextField.dart';

class LicenseRegisterPage extends StatefulWidget {
  const LicenseRegisterPage({Key? key}) : super(key: key);

  @override
  State<LicenseRegisterPage> createState() => _LicenseRegisterPageState();
}

class _LicenseRegisterPageState extends State<LicenseRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Lizenz registrieren",
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: SafeArea(
          child: Column(
        children: [
          const Text("Bitte eine gültige Lizenz eingeben"),
          HiveHelper.isVerified
              ? Container()
              : const LicenseRegisterTextField(),
        ],
      )),
    );
  }
}
