import 'package:flutter/material.dart';

class AndroidAlertDialogCustom {
  static void showAlertDialog(String title, String description,
      BuildContext context, List<Widget> list) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: list,
      ),
    );
  }
}
