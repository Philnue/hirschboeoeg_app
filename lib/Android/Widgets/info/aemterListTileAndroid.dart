import 'package:flutter/material.dart';

class AemterListTileAndroid extends StatelessWidget {
  const AemterListTileAndroid({
    Key? key,
    required this.left,
    required this.right,
  }) : super(key: key);

  final String left, right;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Text(
          left,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        trailing: Text(
          right,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
