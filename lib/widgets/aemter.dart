import 'package:boeoeg_app/widgets/aemterCard.dart';

import 'package:boeoeg_app/widgets/mitgliederView.dart';
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
        const Text(
          "Ämter:",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 69, 13, 13)),
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AemterCard(text: "Alpha:"),
                  const AemterCard(
                    text: "Daniel Lauer",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AemterCard(text: "Beta:"),
                  const AemterCard(
                    text: "Philipp Nüßlein",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AemterCard(text: "Schriftführer:"),
                  const AemterCard(
                    text: "Dennis Hoffmann",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AemterCard(text: "Finanzen"),
                  const AemterCard(text: "Uwe Ziefle"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
