import 'package:a_level_pro/screens/chapter1.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../models/cloud_firestore.dart';

class ChapterBox extends StatefulWidget {
  final String name;

  const ChapterBox({Key? key, required this.name}) : super(key: key);

  @override
  State<ChapterBox> createState() => _ChapterBoxState();
}

class _ChapterBoxState extends State<ChapterBox> {
  @override
  Widget build(BuildContext context) {
    return Ink(
        height: 76,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Constants.grey),
        child: InkWell(
          onTap: () async {
            final result = await DatabaseService().listOfTopics(widget.name);
            final units = [];
            final urls = [];
            for (final e in result) {
              units.add(e['unit']);
              urls.add(e['url']);
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chapters(
                          urls: urls,
                          units: units,
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
