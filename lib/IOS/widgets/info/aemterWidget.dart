import 'package:boeoeg_app/classes/constants/constants.dart';
import 'package:boeoeg_app/IOS/widgets/info/aemterListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AemterWidget extends StatefulWidget {
  const AemterWidget({Key? key}) : super(key: key);

  @override
  State<AemterWidget> createState() => _AemterWidgetState();
}

class _AemterWidgetState extends State<AemterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          //width: double.infinity,
          //height: double.minPositive,
          child: ListView.builder(
              itemCount: Constants.aemterMap.length,
              itemBuilder: (context, index) {
                return AemterListTile(
                    left: Constants.aemterMap[index]["Amt"],
                    right: Constants.aemterMap[index]["Name"]);
              }),
        ),
      ],
    );
  }
}
