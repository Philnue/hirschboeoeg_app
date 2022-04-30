import 'package:boeoeg_app/Android/Widgets/info/aemterListTileAndroid.dart';
import 'package:boeoeg_app/classes/constants/constants.dart';

import 'package:flutter/material.dart';

class AemterWidgetAndroid extends StatefulWidget {
  const AemterWidgetAndroid({Key? key}) : super(key: key);

  @override
  State<AemterWidgetAndroid> createState() => _AemterWidgetAndroidState();
}

class _AemterWidgetAndroidState extends State<AemterWidgetAndroid> {
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
                return AemterListTileAndroid(
                    left: Constants.aemterMap[index]["Amt"],
                    right: Constants.aemterMap[index]["Name"]);
              }),
        ),
      ],
    );
  }
}

// ListView.builder(
//               itemCount: Constants.aemterMap.length,
//               itemBuilder: (context, index) {
//                 return AemterListTileAndroid(
//                     left: Constants.aemterMap[index]["Amt"],
//                     right: Constants.aemterMap[index]["Name"]);
//               }),