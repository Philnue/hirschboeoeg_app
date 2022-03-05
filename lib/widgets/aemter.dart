import 'package:boeoeg_app/widgets/aetmertext.dart';
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
        Text(
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
                  AemterText(text: "Alpha:"),
                  AemterText(
                    text: "Daniel Lauer",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "Beta:"),
                  AemterText(
                    text: "Philipp Nüßlein",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "Schriftführer:"),
                  AemterText(
                    text: "Dennis Hofmann",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "Finanzen:"),
                  AemterText(
                    text: "Uwe Ziefle",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "KA:"),
                  AemterText(
                    text: "Gute Frage",
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
